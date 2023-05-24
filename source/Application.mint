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
  fun load : Promise(Void) {
    if (status == Status::Initial) {
      let request =
        await Http.send(Http.get("http://localhost:3002/documentation.json"))

      let Result::Ok(response) =
        request or return next { status: Status::HttpError }

      let Result::Ok(json) =
        Json.parse(response.bodyString) or return next { status: Status::JsonError }

      let Result::Ok(root) =
        decode json as Root or return next { status: Status::DecodeError }

      next
        {
          documentations: root.packages,
          status: Status::Ok
        }
    }
  }

  /* Navigates to the dashboard. */
  fun dashboard : Promise(Void) {
    await load()

    await next
      {
        documentation: Documentation.empty(),
        selected: Content.empty(),
        page: Page::Dashboard
      }

    Window.setScrollTop(0)
  }

  /* Routes to the given package. */
  fun routePackage (name : String) : Promise(Void) {
    /* Load the documentation.json. */
    await load()

    case (Array.find(documentations, (item : Documentation) : Bool { item.name == name })) {
      Maybe::Nothing => Window.navigate("/")

      Maybe::Just(nextDocumentation) =>
        {
          next
            {
              documentation: nextDocumentation,
              page: Page::Package
            }

          Window.setScrollTop(0)
        }
    }
  }

  /* Handles the routing logic of a tab and enitity. */
  fun route (
    packageName : String,
    tabName : String,
    entity : Maybe(String)
  ) : Promise(Void) {
    /* Load the documentation.json. */
    await load()

    case (Array.find(documentations, (item : Documentation) : Bool { item.name == packageName })) {
      Maybe::Nothing => Window.navigate("/")

      Maybe::Just(nextDocumentation) =>
        case (Type.fromString(tabName)) {
          Result::Err => Window.navigate("/" + nextDocumentation.name)

          Result::Ok(nextTab) =>
            {
              /* Get the converted items from based on the type. */
              let items =
                case (nextTab) {
                  Type::Component => Array.map(nextDocumentation.components, Content.fromComponent)
                  Type::Provider => Array.map(nextDocumentation.providers, Content.fromProvider)
                  Type::Record => Array.map(nextDocumentation.records, Content.fromRecord)
                  Type::Module => Array.map(nextDocumentation.modules, Content.fromModule)
                  Type::Store => Array.map(nextDocumentation.stores, Content.fromStore)
                  Type::Enum => Array.map(nextDocumentation.enums, Content.fromEnum)
                }

              /* Try to show the selected entity. */
              let nextSelectedMaybe =
                entity
                |> Maybe.map(
                  (name : String) : Maybe(Content) {
                    Array.find(items, (item : Content) : Bool { item.name == name })
                  })
                |> Maybe.flatten()

              case (nextSelectedMaybe) {
                Maybe::Just(nextSelected) =>
                  {
                    /* If there is a selected entity show it. */
                    await next
                      {
                        documentation: nextDocumentation,
                        selected: nextSelected,
                        page: Page::Entity,
                        tab: nextTab
                      }

                    Window.setScrollTop(0)
                  }

                Maybe::Nothing =>
                  case (Array.first(items)) {
                    Maybe::Nothing => Window.navigate("/" + nextDocumentation.name)

                    Maybe::Just(first) =>
                      Window.navigate(
                        "/" + nextDocumentation.name + "/" + Type.path(nextTab) + "/" + first.name)
                  }
              }
            }
        }
    }
  }
}
