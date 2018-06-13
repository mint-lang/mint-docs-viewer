store Documentation.Store {
  property components : Array(Component) = []
  property stores : Array(Component) = []
  property selected : String = ""
  property loaded : Bool = false

  fun load : Void {
    if (loaded) {
      void
    } else {
      do {
        response =
          Http.get("http://localhost:3002/_/documentation.json")
          |> Http.send()

        json =
          Json.parse(response.body)
          |> Maybe.toResult("")

        object =
          decode json as Documentation

        next
          { state |
            loaded = true,
            components = object.components,
            stores = object.stores
          }
      } catch Http.ErrorResponse => error {
        void
      } catch String => error {
        void
      } catch Object.Error => error {
        void
      }
    }
  }

  fun select (name : String) : Void {
    next { state | selected = name }
  }
}
