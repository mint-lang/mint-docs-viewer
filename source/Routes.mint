routes {
  /:tab/:selected (tab : String, selected : String) {
    do {
      Application.load()
      Application.selectTab(Type.fromString(tab))
      Application.select(selected)
    }
  }

  /:tab (tab : String) {
    do {
      Application.load()

      tabId =
        Type.fromString(tab)

      empty =
        case (tabId) {
          Type::Component => Array.isEmpty(Application.components)
          Type::Provider => Array.isEmpty(Application.providers)
          Type::Record => Array.isEmpty(Application.records)
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
