store Documentation.Store {
  property tab : Documentation.Type = Documentation.Type::Component
  property components : Array(Component) = []
  property stores : Array(Component) = []
  property modules : Array(Module) = []

  property selected : Content = Content.empty()

  property loaded : Bool = false

  get entityColor : String {
    case (tab) {
      Documentation.Type::Component => "#369e58"
      Documentation.Type::Module => "#be08d0"
      Documentation.Type::Store => "#d02e2e"
    }
  }

  get tabName : String {
    nameOf(tab)
  }

  fun nameOf (tab : Documentation.Type) : String {
    case (tab) {
      Documentation.Type::Component => "component"
      Documentation.Type::Module => "module"
      Documentation.Type::Store => "store"
    }
  }

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
        \item : Component, map : Map(String, Array(Method)) => Map.set(item.name, item.functions, map))
      |> Map.merge(
        Array.Extra.reduce(
          Map.empty(),
          \item : Component, map : Map(String, Array(Method)) => Map.set(item.name, item.functions, map),
          stores))
      |> Map.merge(
        Array.Extra.reduce(
          Map.empty(),
          \item : Module, map : Map(String, Array(Method)) => Map.set(item.name, item.functions, map),
          modules))

    descriptions =
      modules
      |> Array.Extra.reduce(
        Map.empty(),
        \item : Module, map : Map(String, String) =>
          Map.set(
            item.name,
            Maybe.withDefault("", item.description),
            map))
      |> Map.merge(
        Array.Extra.reduce(
          Map.empty(),
          \item : Component, map : Map(String, String) =>
            Map.set(
              item.name,
              Maybe.withDefault("", item.description),
              map),
          components))

    functions =
      Map.get(name, functionsMap)
      |> Maybe.withDefault([])

    description =
      Map.get(name, descriptions)
      |> Maybe.withDefault("")

    selected =
      {
        type = Documentation.Type::Component,
        description = description,
        functions = functions,
        properties = [],
        name = name
      }
  }

  fun selectTab (tab : Documentation.Type) : Void {
    do {
      if (state.tab == tab) {
        void
      } else {
        next { state | tab = tab }
      }

      select(first)
    }
  } where {
    first =
      case (tab) {
        Documentation.Type::Component =>
          components
          |> Array.first()
          |> Maybe.map(\item : Component => item.name)
          |> Maybe.withDefault("")

        Documentation.Type::Module =>
          modules
          |> Array.first()
          |> Maybe.map(\item : Module => item.name)
          |> Maybe.withDefault("")

        Documentation.Type::Store =>
          stores
          |> Array.first()
          |> Maybe.map(\item : Component => item.name)
          |> Maybe.withDefault("")
      }
  }
}

module Array.Extra {
  fun reduce (memo : memo, accumulator : Function(item, memo, memo), array : Array(item)) : memo {
    `
    (() => {
      array.reduce((acc, item) => accumulator(item, acc), memo)
      return memo
    })()
    `
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
      const map = new Map()

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
