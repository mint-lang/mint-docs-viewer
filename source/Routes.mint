routes {
  /:tab/:selected (tab : String, selected : String) {
    do {
      tabId =
        case (tab) {
          "component" => Type::Component
          "module" => Type::Module
          "store" => Type::Store
          => Type::Component
        }

      Application.load()
      Application.selectTab(tabId)
      Application.select(selected)
    }
  }

  /:tab (tab : String) {
    do {
      Application.load()

      tabId =
        case (tab) {
          "component" => Type::Component
          "module" => Type::Module
          "store" => Type::Store
          => Type::Component
        }

      empty =
        case (tabId) {
          Type::Component => Array.isEmpty(Application.components)
          Type::Module => Array.isEmpty(Application.modules)
          Type::Store => Array.isEmpty(Application.stores)
        }

      if (empty) {
        Window.navigate("/")
      } else {
        do {
          Application.selectTab(tabId)
        }
      }
    }
  }

  * {
    do {
      Application.load()
      Application.selectTab(Type::Component)
    }
  }
}
