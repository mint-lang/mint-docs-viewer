/* A component for the top-level entity tabs. */
component Tabs {
  connect Application exposing { entityColor, stores, components, modules }

  style base {
    border-bottom: 5px solid {entityColor};
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
    </div>
  }
}
