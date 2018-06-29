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
  providers : Array(Use),
  state : Maybe(State),
  name : String
}

/* Represents a provider use. */
record Use {
  condition : Maybe(String),
  provider : String,
  data : String
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
  options : Array(EnumOption),
  connects : Array(Connect),
  functions : Array(Method),
  description : String,
  state : Maybe(State),
  uses : Array(Use),
  name : String
}

/* Represents the documentation of an application or package. */
record Documentation {
  components : Array(Component),
  providers : Array(Provider),
  records : Array(Record),
  modules : Array(Module),
  stores : Array(Store),
  enums : Array(Enum)
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

/* Represents an enum. */
record Enum {
  description : Maybe(String),
  options : Array(EnumOption),
  name : String
}

/* Represents an enum option. */
record EnumOption {
  description : Maybe(String),
  name : String
}

/* Represents the possible top-level entities. */
enum Type {
  Component
  Provider
  Record
  Module
  Store
  Enum
}

/* Represents the status of the application. */
enum Status {
  /* An error occured when trying to decode the `documentation.json` */
  DecodeError

  /* An error occured when trying to parse the `documentation.json` */
  HttpError

  /* An error occured when trying to load the `documentation.json` */
  JsonError

  /* The initial state */
  Initial

  /* The `documentation.json` loaded, parsed and decoded properly */
  Ok
}
