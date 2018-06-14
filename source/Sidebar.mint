component Documentation.Sidebar {
  connect Documentation.Store exposing { components, stores, tab, modules }

  style base {
    background: #F5F5F5;
    color: #444;

    padding: 20px;
    padding-right: 40px;
  }

  style separator {
    margin-top: 30px;
  }

  fun render : Html {
    <div::base>
      <{ items }>
    </div>
  } where {
    items =
      case (tab) {
        Documentation.Type::Component =>
          components
          |> Array.map(
            \item : Component => <Documentation.Sidebar.Item name={item.name}/>)

        Documentation.Type::Store =>
          stores
          |> Array.map(
            \item : Component =>
              <Documentation.Sidebar.Item
                name={item.name}
                type={Documentation.Type::Store}/>)

        Documentation.Type::Module =>
          modules
          |> Array.map(
            \item : Module =>
              <Documentation.Sidebar.Item
                name={item.name}
                type={Documentation.Type::Module}/>)
      }
  }
}
