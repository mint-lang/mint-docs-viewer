/* A component for the sidebar. */
component Sidebar {
  connect Application exposing { documentation, tab }

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
        documentation.components
        |> Array.map(
          (item : Component) : Html {
            <Sidebar.Item
              type={Type::Component}
              text={item.name}/>
          })

      Type::Provider =>
        documentation.providers
        |> Array.map(
          (item : Provider) : Html {
            <Sidebar.Item
              type={Type::Provider}
              text={item.name}/>
          })

      Type::Store =>
        documentation.stores
        |> Array.map(
          (item : Store) : Html {
            <Sidebar.Item
              type={Type::Store}
              text={item.name}/>
          })

      Type::Record =>
        documentation.records
        |> Array.map(
          (item : Record) : Html {
            <Sidebar.Item
              type={Type::Record}
              text={item.name}/>
          })

      Type::Module =>
        documentation.modules
        |> Array.map(
          (item : Module) : Html {
            <Sidebar.Item
              type={Type::Module}
              text={item.name}/>
          })

      Type::Enum =>
        documentation.enums
        |> Array.map(
          (item : Enum) : Html {
            <Sidebar.Item
              type={Type::Enum}
              text={item.name}/>
          })
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ items }>
    </div>
  }
}
