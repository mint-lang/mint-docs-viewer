component Main {
  connect Documentation.Store exposing { load, components, stores, selected }

  style base {
    font-family: sans-serif;
    flex-direction: column;
    min-height: 100vh;
    display: flex;
    color: #333;
  }

  style content {
    display: flex;
    flex: 1;
  }

  get content : Html {
    <Documentation.Content/>
  }

  fun render : Html {
    <div::base>
      <Documentation.Tabs/>

      <div::content>
        <Documentation.Sidebar/>
        <{ content }>
      </div>
    </div>
  }
}

routes {
  /:tab/:selected (tab : String, selected : String) {
    do {
      tabId =
        case (tab) {
          "component" => Documentation.Type::Component
          "module" => Documentation.Type::Module
          "store" => Documentation.Type::Store
          => Documentation.Type::Component
        }

      Documentation.Store.load()
      Documentation.Store.selectTab(tabId)
      Documentation.Store.select(selected)
    }
  }

  /:tab (tab : String) {
    do {
      Documentation.Store.load()

      tabId =
        case (tab) {
          "component" => Documentation.Type::Component
          "module" => Documentation.Type::Module
          "store" => Documentation.Type::Store
          => Documentation.Type::Component
        }

      empty =
        case (tabId) {
          Documentation.Type::Component => Array.isEmpty(Documentation.Store.components)
          Documentation.Type::Module => Array.isEmpty(Documentation.Store.modules)
          Documentation.Type::Store => Array.isEmpty(Documentation.Store.stores)
        }

      if (empty) {
        Window.navigate("/")
      } else {
        do {
          Documentation.Store.selectTab(tabId)
        }
      }
    }
  }

  * {
    do {
      Documentation.Store.load()
      Documentation.Store.selectTab(Documentation.Type::Component)
    }
  }
}
