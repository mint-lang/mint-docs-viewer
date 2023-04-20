/* Utility functions for the `Documentation` type. */
module Documentation {
  /* Returns an empty documentation object. */
  fun empty : Documentation {
    {
      dependencies: [],
      components: [],
      providers: [],
      modules: [],
      records: [],
      stores: [],
      enums: [],
      name: ""
    }
  }
}
