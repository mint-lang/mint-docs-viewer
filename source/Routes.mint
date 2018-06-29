routes {
  /:tab/:selected (tab : String, selected : String) {
    Application.route(tab, Maybe.just(selected))
  }

  /:tab (tab : String) {
    Application.route(tab, Maybe.nothing())
  }

  * {
    Application.route("component", Maybe.nothing())
  }
}
