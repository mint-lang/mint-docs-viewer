routes {
  /:package/:tab/:selected (package : String, tab : String, selected : String) {
    Application.route(package, tab, Maybe.just(selected))
  }

  /:package/:tab (package : String, tab : String) {
    Application.route(package, tab, Maybe.nothing())
  }

  /:package (package : String) {
    Application.routePackage(package)
  }

  / {
    Application.dashboard()
  }

  * {
    Application.route("", "component", Maybe.nothing())
  }
}
