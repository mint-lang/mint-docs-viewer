/* The main store of the application. */
store Application {
  /* The selected entity. */
  property selected : Content = Content.empty()

  /* The status of the page. */
  property status : Status = Status::Initial

  /* The selected tab. */
  property tab : Type = Type::Component

  /* All documentations of the packages. */
  property documentations : Array(Documentation) = []

  /* The selected packages documentation. */
  property documentation : Documentation = Documentation.empty()

  /* The current page. */
  property page : Page = Page::Dashboard

  /* Loads the documentation. */
  fun load : Void {
    if (status == Status::Initial) {
      do {
        response =
          Http.get("http://localhost:3002/documentation.json")
          |> Http.send()

        json =
          Json.parse(response.body)
          |> Maybe.toResult("")

        root =
          decode json as Root

        next
          { state |
            documentations = root.packages,
            status = Status::Ok
          }
      } catch Http.ErrorResponse => error {
        next { state | status = Status::HttpError }
      } catch String => error {
        next { state | status = Status::JsonError }
      } catch Object.Error => error {
        next { state | status = Status::DecodeError }
      }
    } else {
      void
    }
  }

  /* Navigates to the dashboard. */
  fun dashboard : Void {
    do {
      load()

      next
        { state |
          documentation = Documentation.empty(),
          selected = Content.empty(),
          page = Page::Dashboard
        }

      Window.setScrollTop(0)
    }
  }

  /* Routes to the given package. */
  fun routePackage (name : String) : Void {
    do {
      /* Load the documentation.json. */
      load()

      /* Try to find the package. */
      documentation =
        documentations
        |> Array.find(\item : Documentation => item.name == name)
        |> Maybe.toResult("Could not find package!")

      next
        { state |
          documentation = documentation,
          page = Page::Package
        }

      Window.setScrollTop(0)
      /* If we could not the package. */
    } catch String => error {
      do {
        Debug.log(error)
        Window.navigate("/")
      }
    }
  }

  /* Handles the routing logic of a tab and enitity. */
  fun route (packageName : String, tabName : String, entity : Maybe(String)) : Void {
    do {
      /* Load the documentation.json. */
      load()

      /* Try to find the package. */
      documentation =
        documentations
        |> Array.find(\item : Documentation => item.name == packageName)
        |> Maybe.toResult("Could not find package!")

      do {
        /* Get the type from string. */
        tab =
          Type.fromString(tabName)

        /* Get the converted items from based on the type. */
        items =
          case (tab) {
            Type::Component => Array.map(Content.fromComponent, documentation.components)
            Type::Provider => Array.map(Content.fromProvider, documentation.providers)
            Type::Record => Array.map(Content.fromRecord, documentation.records)
            Type::Module => Array.map(Content.fromModule, documentation.modules)
            Type::Store => Array.map(Content.fromStore, documentation.stores)
            Type::Enum => Array.map(Content.fromEnum, documentation.enums)
          }

        /* Try to show the selected entity. */
        do {
          selected =
            entity
            |> Maybe.map(
              \name : String => Array.find(\item : Content => item.name == name, items))
            |> Maybe.flatten()
            |> Maybe.toResult("Could not find entity!")

          /* If there is a selected entity show it. */
          next
            { state |
              documentation = documentation,
              page = Page::Entity,
              selected = selected,
              tab = tab
            }

          Window.setScrollTop(0)
          /* If there is not try to navigate to the first item. */
        } catch String => error {
          do {
            first =
              items
              |> Array.first()
              |> Maybe.toResult("Could not find first!")

            /* If there is a first item navigate to it. */
            Window.navigate(
              "/" + documentation.name + "/" + Type.path(tab) + "/" + first.name)

            /* If there is not navigate to root. */
          } catch String => error {
            Window.navigate("/" + documentation.name)
          }
        }

        /* If we could not find a proper type. */
      } catch String => error {
        Window.navigate("/" + documentation.name)
      }

      /* If we could not the package. */
    } catch String => error {
      Window.navigate("/")
    }
  }
}
