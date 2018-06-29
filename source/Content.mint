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
