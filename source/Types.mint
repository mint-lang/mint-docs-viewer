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

/* Represents a store connection. */
record Connect {
  keys : Array(String),
  store : String
}

/* Represents a component. */
record Component {
  computedProperties : Array(ComputedProperty) from "computed-properties",
  properties : Array(Property),
  description : Maybe(String),
  connects : Array(Connect),
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

/* Represents a provider. */
record Provider {
  description : Maybe(String),
  functions : Array(Method),
  subscription : String,
  name : String
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
  fields : Array(RecordField),
  connects : Array(Connect),
  functions : Array(Method),
  description : String,
  state : Maybe(State),
  name : String
}

/* Represents the documentation of an application or package. */
record Documentation {
  components : Array(Component),
  providers : Array(Provider),
  records : Array(Record),
  modules : Array(Module),
  stores : Array(Store)
}

/* Represents a record field. */
record RecordField {
  mapping : Maybe(String),
  type : String,
  key : String
}

/* Represents a record. */
record Record {
  fields : Array(RecordField),
  description : Maybe(String),
  name : String
}

enum Type {
  Component
  Provider
  Record
  Module
  Store
}

enum Status {
  DecodeError
  HttpError
  JsonError
  Initial
  Ok
}
