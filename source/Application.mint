/* The main store of the application. */
store Application {
  /* The components. */
  property components : Array(Component) = []

  /* The providers. */
  property providers : Array(Provider) = []

  /* The records. */
  property records : Array(Record) = []

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
            components = object.components,
            providers = object.providers,
            modules = object.modules,
            records = object.records,
            stores = object.stores,
            status = Status::Ok
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
    items =
      case (tab) {
        Type::Component => Array.map(Content.fromComponent, components)
        Type::Provider => Array.map(Content.fromProvider, providers)
        Type::Record => Array.map(Content.fromRecord, records)
        Type::Module => Array.map(Content.fromModule, modules)
        Type::Store => Array.map(Content.fromStore, stores)
      }

    selected =
      items
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

        Type::Provider =>
          providers
          |> Array.first()
          |> Maybe.map(\item : Provider => item.name)
          |> Maybe.withDefault("")

        Type::Record =>
          records
          |> Array.first()
          |> Maybe.map(\item : Record => item.name)
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
