component Documentation.Sidebar {
  connect Documentation.Store exposing { components, stores }

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
      <Documentation.Sidebar.Header text="Components"/>
      <{ componentItems }>

      <div::separator/>

      <Documentation.Sidebar.Header text="Stores"/>
      <{ storeItems }>
    </div>
  } where {
    componentItems =
      components
      |> Array.map(
        \item : Component => <Documentation.Sidebar.Item name={item.name}/>)

    storeItems =
      stores
      |> Array.map(
        \item : Component =>
          <Documentation.Sidebar.Item
            name={item.name}
            type={Documentation.Type::Store}/>)
  }
}
