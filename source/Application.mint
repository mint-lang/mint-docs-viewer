/* The main store of the application. */
store Application {
  /* The components. */
  property components : Array(Component) = []

  /* The modules. */
  property modules : Array(Module) = []

  /* The store. */
  property stores : Array(Store) = []

  /* The selected entity. */
  property selected : Content = Content.empty()

  /* The status of the page. */
  property status : Status = Status::Initial

  /* The selected tab. */
  property tab : Type = Type::Component

  /* Returns the color of the current entity. */
  get entityColor : String {
    case (tab) {
      Type::Component => "#369e58"
      Type::Module => "#be08d0"
      Type::Store => "#d02e2e"
    }
  }

  /* Returns the name of the current tab. */
  get tabName : String {
    nameOf(tab)
  }

  /* Returns the nam ef the given type. */
  fun nameOf (tab : Type) : String {
    case (tab) {
      Type::Component => "component"
      Type::Module => "module"
      Type::Store => "store"
    }
  }

  /* Loads the documentation. */
  fun load : Void {
    if (status == Status::Initial) {
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
            status = Status::Ok,
            components = object.components,
            modules = object.modules,
            stores = object.stores
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

  /* Selects an entity with the given name. */
  fun select (name : String) : Void {
    next { state | selected = selected }
  } where {
    componentContents =
      Array.map(
        \item : Component => Content.fromComponent(item),
        components)

    moduleContents =
      Array.map(\item : Module => Content.fromModule(item), modules)

    storeContents =
      Array.map(\item : Store => Content.fromStore(item), stores)

    selected =
      componentContents
      |> Array.Extra.concat(storeContents)
      |> Array.Extra.concat(moduleContents)
      |> Array.find(\item : Content => item.name == name)
      |> Maybe.withDefault(Content.empty())
  }

  /* Selects the given tab. */
  fun selectTab (tab : Type) : Void {
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
        Type::Component =>
          components
          |> Array.first()
          |> Maybe.map(\item : Component => item.name)
          |> Maybe.withDefault("")

        Type::Module =>
          modules
          |> Array.first()
          |> Maybe.map(\item : Module => item.name)
          |> Maybe.withDefault("")

        Type::Store =>
          stores
          |> Array.first()
          |> Maybe.map(\item : Store => item.name)
          |> Maybe.withDefault("")
      }
  }
}

module Array.Extra {
  fun concat (array1 : Array(a), array2 : Array(a)) : Array(a) {
    `array1.concat(array2)`
  }

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
