record Property {
  defaultValue : String from "default",
  name : String,
  type : String
}

record Component {
  properties : Array(Property),
  name : String
}

record Documentation {
  components : Array(Component),
  stores : Array(Component)
}

enum Documentation.Type {
  Component,
  Module,
  Store
}
