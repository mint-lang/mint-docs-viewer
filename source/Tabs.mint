/* A component for the top-level entity tabs. */
component Tabs {
  connect Application exposing { documentation, tab }

  style base {
    border-bottom: 5px solid {Type.color(tab)};
    font-weight: bold;
    background: #333;
    display: flex;
    color: #EEE;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <Unless condition={Array.isEmpty(documentation.components)}>
        <Tab of={Type::Component}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.modules)}>
        <Tab of={Type::Module}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.stores)}>
        <Tab of={Type::Store}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.providers)}>
        <Tab of={Type::Provider}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.records)}>
        <Tab of={Type::Record}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.enums)}>
        <Tab of={Type::Enum}/>
      </Unless>

      <a href="/">
        <{ "Dashboard" }>
      </a>
    </div>
  }
}
