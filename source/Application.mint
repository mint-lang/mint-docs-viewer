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

  /* The store. */
  property enums : Array(Enum) = []

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
            enums = object.enums,
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

  /* Handles the routing logic of a tab and enitity. */
  fun route (tabName : String, entity : Maybe(String)) : Void {
    do {
      /* Load the documentation.json. */
      Application.load()

      /* Get the type from string. */
      tab =
        Type.fromString(tabName)

      /* Get the converted items from based on the type. */
      items =
        case (tab) {
          Type::Component => Array.map(Content.fromComponent, components)
          Type::Provider => Array.map(Content.fromProvider, providers)
          Type::Record => Array.map(Content.fromRecord, records)
          Type::Module => Array.map(Content.fromModule, modules)
          Type::Store => Array.map(Content.fromStore, stores)
          Type::Enum => Array.map(Content.fromEnum, enums)
        }

      /* Try to show the selected entity. */
      do {
        selected =
          entity
          |> Maybe.map(
            \name : String => Array.find(\item : Content => item.name == name, items))
          |> Maybe.Extra.flatten()
          |> Maybe.toResult("Could not find entity!")

        /* If there is a selected entity show it. */
        next
          { state |
            selected = selected,
            tab = tab
          }

        /* If there is not try to navigate to the first item. */
      } catch String => error {
        do {
          first =
            Array.first(items)
            |> Maybe.toResult("Could not find first!")

          /* If there is a first item navigate to it. */
          Window.navigate("/" + Type.path(tab) + "/" + first.name)

          /* If there is not navigate to root. */
        } catch String => error {
          Window.navigate("/")
        }
      }

      /* If we could not find a proper type. */
    } catch String => error {
      Window.navigate("/")
    }
  }
}

module Maybe.Extra {
  fun flatten (maybe : Maybe(Maybe(a))) : Maybe(a) {
    `
    (() => {
      if (maybe instanceof Just) {
        return maybe.value
      } else {
        return maybe
      }
    })()
    `
  }

  fun oneOf (array : Array(Maybe(a))) : Maybe(a) {
    array
    |> Array.find(\item : Maybe(a) => Maybe.isJust(item))
    |> flatten()
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
