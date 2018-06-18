component Documentation.Tabs {
  connect Documentation.Store exposing { entityColor }

  style base {
    border-bottom: 5px solid {entityColor};
    font-weight: bold;
    background: #333;
    display: flex;
    color: #EEE;
  }

  fun render : Html {
    <div::base>
      <Documentation.Tab of={Documentation.Type::Component}/>
      <Documentation.Tab of={Documentation.Type::Module}/>
      <Documentation.Tab of={Documentation.Type::Store}/>
    </div>
  }
}
