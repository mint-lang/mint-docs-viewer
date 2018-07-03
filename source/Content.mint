/* Utility functions for the `Content` type. */
module Content {
  /* Creates a new `Content` from a `Component`. */
  fun fromComponent (item : Component) : Content {
    {
      description = Maybe.withDefault("", item.description),
      computedProperties = item.computedProperties,
      properties = item.properties,
      functions = item.functions,
      connects = item.connects,
      uses = item.providers,
      state = item.state,
      subscription = "",
      name = item.name,
      options = [],
      fields = []
    }
  }

  /* Creates a new `Content` from a `Record`. */
  fun fromRecord (item : Record) : Content {
    {
      description = Maybe.withDefault("", item.description),
      state = Maybe.nothing(),
      computedProperties = [],
      fields = item.fields,
      subscription = "",
      name = item.name,
      properties = [],
      functions = [],
      connects = [],
      options = [],
      uses = []
    }
  }

  /* Creates a new `Content` from an `Enum`. */
  fun fromEnum (item : Enum) : Content {
    {
      description = Maybe.withDefault("", item.description),
      state = Maybe.nothing(),
      computedProperties = [],
      options = item.options,
      subscription = "",
      name = item.name,
      properties = [],
      functions = [],
      connects = [],
      fields = [],
      uses = []
    }
  }

  /* Creates a new `Content` from a `Provider`. */
  fun fromProvider (item : Provider) : Content {
    {
      description = Maybe.withDefault("", item.description),
      subscription = item.subscription,
      functions = item.functions,
      computedProperties = [],
      state = Maybe.nothing(),
      name = item.name,
      properties = [],
      connects = [],
      options = [],
      fields = [],
      uses = []
    }
  }

  /* Creates a new `Content` from a `Store`. */
  fun fromStore (item : Store) : Content {
    {
      description = Maybe.withDefault("", item.description),
      computedProperties = item.computedProperties,
      properties = item.properties,
      functions = item.functions,
      state = Maybe.nothing(),
      subscription = "",
      name = item.name,
      connects = [],
      options = [],
      fields = [],
      uses = []
    }
  }

  /* Creates a new `Content` from a `Module`. */
  fun fromModule (item : Module) : Content {
    {
      description = Maybe.withDefault("", item.description),
      functions = item.functions,
      state = Maybe.nothing(),
      computedProperties = [],
      subscription = "",
      name = item.name,
      properties = [],
      connects = [],
      options = [],
      fields = [],
      uses = []
    }
  }

  /* Creates a new empty `Content`. */
  fun empty : Content {
    {
      state = Maybe.nothing(),
      computedProperties = [],
      subscription = "",
      description = "",
      properties = [],
      functions = [],
      connects = [],
      options = [],
      fields = [],
      uses = [],
      name = ""
    }
  }
}
