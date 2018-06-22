component Documentation.Tabs {
  connect Documentation.Store exposing { entityColor, stores, components, modules }

  style base {
    border-bottom: 5px solid {entityColor};
    font-weight: bold;
    background: #333;
    display: flex;
    color: #EEE;
  }

  fun render : Html {
    <div::base>
      <Unless condition={Array.isEmpty(components)}>
        <Documentation.Tab of={Documentation.Type::Component}/>
      </Unless>

      <Unless condition={Array.isEmpty(modules)}>
        <Documentation.Tab of={Documentation.Type::Module}/>
      </Unless>

      <Unless condition={Array.isEmpty(stores)}>
        <Documentation.Tab of={Documentation.Type::Store}/>
      </Unless>
    </div>
  }
}
