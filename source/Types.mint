/* Represents a property. */
record Property {
  defaultValue : String from "default",
  description : Maybe(String),
  name : String,
  type : String
}

/* Represents a computed property (get). */
record ComputedProperty {
  description : Maybe(String),
  source : String,
  name : String,
  type : String
}

/* Represents a components state. */
record State {
  data : String,
  type : String
}

/* Represents a component. */
record Component {
  computedProperties : Array(ComputedProperty) from "computed-properties",
  properties : Array(Property),
  description : Maybe(String),
  functions : Array(Method),
  state : Maybe(State),
  name : String
}

/* Represents a store. */
record Store {
  computedProperties : Array(ComputedProperty) from "computed-properties",
  properties : Array(Property),
  description : Maybe(String),
  functions : Array(Method),
  name : String
}

/* Represents a function. */
record Method {
  arguments : Array(Argument),
  description : Maybe(String),
  source : String,
  name : String,
  type : String
}

/* Represents a function argument. */
record Argument {
  name : String,
  type : String
}

/* Represents a module. */
record Module {
  description : Maybe(String),
  functions : Array(Method),
  name : String
}

/* Represents the content of the page. */
record Content {
  computedProperties : Array(ComputedProperty),
  properties : Array(Property),
  functions : Array(Method),
  description : String,
  name : String
}

/* Represents the documentation of an application or package. */
record Documentation {
  components : Array(Component),
  modules : Array(Module),
  stores : Array(Store)
}

enum Type {
  Component
  Module
  Store
}

enum Status {
  HttpError
  JsonError
  DecodeError
  Initial
  Ok
}
