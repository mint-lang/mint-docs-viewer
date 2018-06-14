record Property {
  defaultValue : String from "default",
  name : String,
  type : String
}

record Component {
  properties : Array(Property),
  functions : Array(Method),
  name : String
}

record Method {
  name : String
}

record Module {
  functions : Array(Method),
  name : String
}

record Content {
  properties : Array(Property),
  type : Documentation.Type,
  functions : Array(Method),
  name : String
}

record Documentation {
  components : Array(Component),
  stores : Array(Component),
  modules : Array(Module)
}

enum Documentation.Type {
  Component,
  Module,
  Store
}
