/* The main store of the application. */
store Application {
  /* The selected entity. */
  state selected : Content = Content.empty()

  /* The status of the page. */
  state status : Status = Status::Initial

  /* The selected tab. */
  state tab : Type = Type::Component

  /* All documentations of the packages. */
  state documentations : Array(Documentation) = []

  /* The selected packages documentation. */
  state documentation : Documentation = Documentation.empty()

  /* The current page. */
  state page : Page = Page::Dashboard

  /* Loads the documentation. */
  fun load : Promise(Never, Void) {
    if (status == Status::Initial) {
      sequence {
        response =
          Http.get("http://localhost:3002/documentation.json")
          |> Http.send()

        json =
          Json.parse(response.body)
          |> Maybe.toResult("")

        root =
          decode json as Root

        next
          {
            documentations = root.packages,
            status = Status::Ok
          }
      } catch Http.ErrorResponse => error {
        next { status = Status::HttpError }
      } catch String => error {
        next { status = Status::JsonError }
      } catch Object.Error => error {
        sequence {
          Debug.log(Object.Error.toString(error))
          next { status = Status::DecodeError }
        }
      }
    } else {
      Promise.never()
    }
  }

  /* Navigates to the dashboard. */
  fun dashboard : Promise(Never, Void) {
    sequence {
      load()

      next
        {
          documentation = Documentation.empty(),
          selected = Content.empty(),
          page = Page::Dashboard
        }

      Window.setScrollTop(0)
    }
  }

  /* Routes to the given package. */
  fun routePackage (name : String) : Promise(Never, Void) {
    sequence {
      /* Load the documentation.json. */
      load()

      /* Try to find the package. */
      nextDocumentation =
        documentations
        |> Array.find(
          (item : Documentation) : Bool { item.name == name })
        |> Maybe.toResult("Could not find package!")

      next
        {
          documentation = nextDocumentation,
          page = Page::Package
        }

      Window.setScrollTop(0)

      /* If we could not find the package. */
    } catch String => error {
      Window.navigate("/")
    }
  }

  /* Handles the routing logic of a tab and enitity. */
  fun route (
    packageName : String,
    tabName : String,
    entity : Maybe(String)
  ) : Promise(Never, Void) {
    sequence {
      /* Load the documentation.json. */
      load()

      /* Try to find the package. */
      nextDocumentation =
        documentations
        |> Array.find(
          (item : Documentation) : Bool { item.name == packageName })
        |> Maybe.toResult("Could not find package!")

      sequence {
        /* Get the type from string. */
        nextTab =
          Type.fromString(tabName)

        /* Get the converted items from based on the type. */
        items =
          case (nextTab) {
            Type::Component => Array.map(Content.fromComponent, nextDocumentation.components)
            Type::Provider => Array.map(Content.fromProvider, nextDocumentation.providers)
            Type::Record => Array.map(Content.fromRecord, nextDocumentation.records)
            Type::Module => Array.map(Content.fromModule, nextDocumentation.modules)
            Type::Store => Array.map(Content.fromStore, nextDocumentation.stores)
            Type::Enum => Array.map(Content.fromEnum, nextDocumentation.enums)
          }

        /* Try to show the selected entity. */
        sequence {
          nextSelected =
            entity
            |> Maybe.map(
              (name : String) : Maybe(Content) {
                Array.find(
                  (item : Content) : Bool { item.name == name },
                  items)
              })
            |> Maybe.flatten()
            |> Maybe.toResult("Could not find entity!")

          /* If there is a selected entity show it. */
          next
            {
              documentation = nextDocumentation,
              selected = nextSelected,
              page = Page::Entity,
              tab = nextTab
            }

          Window.setScrollTop(0)

          /* If there is not try to navigate to the first item. */
        } catch {
          sequence {
            first =
              items
              |> Array.first()
              |> Maybe.toResult("Could not find first!")

            /* If there is a first item navigate to it. */
            Window.navigate(
              "/" + nextDocumentation.name + "/" + Type.path(nextTab) + "/" + first.name)

            /* If there is not navigate to root. */
          } catch {
            Window.navigate("/" + nextDocumentation.name)
          }
        }

        /* If we could not find a proper type. */
      } catch {
        Window.navigate("/" + nextDocumentation.name)
      }

      /* If we could not the package. */
    } catch {
      Window.navigate("/")
    }
  }
}
