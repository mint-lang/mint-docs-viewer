store Documentation.Store {
  property tab : Documentation.Type = Documentation.Type::Component
  property components : Array(Component) = []
  property stores : Array(Component) = []
  property modules : Array(Module) = []

  property selected : Content = {
    properties = [],
    type = Documentation.Type::Component,
    functions = [],
    name = ""
  }

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
            modules = object.modules,
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
    next { state | selected = selected }
  } where {
    functionsMap =
      components
      |> Array.Extra.reduce(
        Map.empty(),
        \item : Component, map : Map(String, Method) => Map.set(item.name, item.functions, map))
      |> Map.merge(
        Array.Extra.reduce(
          Map.empty(),
          \item : Component, map : Map(String, Method) => Map.set(item.name, item.functions, map),
          stores))
      |> Map.merge(
        Array.Extra.reduce(
          Map.empty(),
          \item : Module, map : Map(String, Method) => Map.set(item.name, item.functions, map),
          modules))

    functions =
      Map.get(name, functionsMap)
      |> Maybe.withDefault([])

    selected =
      {
        type = Documentation.Type::Component,
        functions = functions,
        properties = [],
        name = name
      }
  }

  fun selectTab (tab : Documentation.Type) : Void {
    next { state | tab = tab }
  }
}

module Array.Extra {
  fun reduce (memo : e, accumulator : Function(g, e, e), array : Array(g)) : e {
    `array.reduce(accumulator, memo)`
  }
}

module Map {
  fun empty : Map(x, z) {
    `new Map()`
  }

  fun set (key : x, value : z, map : Map(x, z)) : Map(x, z) {
    `
    (() => {
      map.set(key, value)
      return map
    })()
    `
  }

  fun get (key : x, map : Map(x, z)) : Maybe(z) {
    `
    (() => {
      if (map.has(key)) {
        return new Just(map.get(key))
      } else {
        return new Nothing()
      }
    })()
    `
  }

  fun merge (map1 : Map(x, z), map2 : Map(x, z)) : Map(x, z) {
    `
    (() => {
      map = new Map()

      for (let item of map1) {
        map.set(item[0], item[1])
      }

      for (let item of map2) {
        map.set(item[0], item[1])
      }
      return map
    })()
    `
  }
}
