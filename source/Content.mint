/* Utility functions for the `Content` type. */
module Content {
  /* Creates a new `Content` from a `Component`. */
  fun fromComponent (item : Component) : Content {
    {
      computedProperties: item.computedProperties,
      description: item.description or "",
      properties: item.properties,
      functions: item.functions,
      connects: item.connects,
      uses: item.providers,
      states: item.states,
      subscription: "",
      name: item.name,
      parameters: [],
      options: [],
      fields: []
    }
  }

  /* Creates a new `Content` from a `Record`. */
  fun fromRecord (item : Record) : Content {
    {
      description: item.description or "",
      computedProperties: [],
      fields: item.fields,
      subscription: "",
      name: item.name,
      properties: [],
      parameters: [],
      functions: [],
      connects: [],
      options: [],
      states: [],
      uses: []
    }
  }

  /* Creates a new `Content` from an `Enum`. */
  fun fromEnum (item : Enum) : Content {
    {
      description: item.description or "",
      parameters: item.parameters,
      computedProperties: [],
      options: item.options,
      subscription: "",
      name: item.name,
      properties: [],
      functions: [],
      connects: [],
      fields: [],
      states: [],
      uses: []
    }
  }

  /* Creates a new `Content` from a `Provider`. */
  fun fromProvider (item : Provider) : Content {
    {
      description: item.description or "",
      subscription: item.subscription,
      functions: item.functions,
      computedProperties: [],
      name: item.name,
      parameters: [],
      properties: [],
      connects: [],
      options: [],
      fields: [],
      states: [],
      uses: []
    }
  }

  /* Creates a new `Content` from a `Store`. */
  fun fromStore (item : Store) : Content {
    {
      computedProperties: item.computedProperties,
      description: item.description or "",
      functions: item.functions,
      states: item.states,
      subscription: "",
      name: item.name,
      parameters: [],
      properties: [],
      connects: [],
      options: [],
      fields: [],
      uses: []
    }
  }

  /* Creates a new `Content` from a `Module`. */
  fun fromModule (item : Module) : Content {
    {
      description: item.description or "",
      functions: item.functions,
      computedProperties: [],
      subscription: "",
      name: item.name,
      parameters: [],
      properties: [],
      connects: [],
      options: [],
      states: [],
      fields: [],
      uses: []
    }
  }

  /* Creates a new empty `Content`. */
  fun empty : Content {
    {
      computedProperties: [],
      subscription: "",
      description: "",
      parameters: [],
      properties: [],
      functions: [],
      connects: [],
      options: [],
      fields: [],
      states: [],
      uses: [],
      name: ""
    }
  }
}
