/* A component for the sidebar. */
component Sidebar {
  connect Application exposing { components, stores, tab, modules }

  style base {
    background: #F5F5F5;
    color: #444;

    padding: 20px;
    padding-right: 40px;
  }

  style separator {
    margin-top: 30px;
  }

  /* Returns the renderd items in the sidebar. */
  get items : Array(Html) {
    case (tab) {
      Type::Component =>
        components
        |> Array.map(
          \item : Component =>
            <Sidebar.Item
              type={Type::Component}
              text={item.name}/>)

      Type::Store =>
        stores
        |> Array.map(
          \item : Store =>
            <Sidebar.Item
              type={Type::Store}
              text={item.name}/>)

      Type::Module =>
        modules
        |> Array.map(
          \item : Module =>
            <Sidebar.Item
              type={Type::Module}
              text={item.name}/>)
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ items }>
    </div>
  }
}
