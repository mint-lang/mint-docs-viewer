/* A component for the top-level entity tabs. */
component Tabs {
  connect Application exposing {
    components,
    providers,
    modules,
    stores,
    records,
    enums,
    tab
  }

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
      <Unless condition={Array.isEmpty(components)}>
        <Tab of={Type::Component}/>
      </Unless>

      <Unless condition={Array.isEmpty(modules)}>
        <Tab of={Type::Module}/>
      </Unless>

      <Unless condition={Array.isEmpty(stores)}>
        <Tab of={Type::Store}/>
      </Unless>

      <Unless condition={Array.isEmpty(providers)}>
        <Tab of={Type::Provider}/>
      </Unless>

      <Unless condition={Array.isEmpty(records)}>
        <Tab of={Type::Record}/>
      </Unless>

      <Unless condition={Array.isEmpty(enums)}>
        <Tab of={Type::Enum}/>
      </Unless>
    </div>
  }
}
