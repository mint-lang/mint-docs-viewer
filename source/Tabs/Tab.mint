component Documentation.Tab {
  connect Documentation.Store exposing { selectTab, tab }

  property of : Documentation.Type = Documentation.Type::Component

  style base {
    border-bottom: 5px solid {background};
    padding: 15px 20px;
    cursor: pointer;

    &:hover {
      background: #444;
    }
  }

  get active : Bool {
    tab == of
  }

  get title : String {
    case (of) {
      Documentation.Type::Component => "Components"
      Documentation.Type::Module => "Modules"
      Documentation.Type::Store => "Stores"
    }
  }

  get background : String {
    if (active) {
      "#777"
    } else {
      "transparent"
    }
  }

  fun render : Html {
    <div::base onClick={\event : Html.Event => selectTab(of)}>
      <{ title }>
    </div>
  }
}

component Documentation.Tabs {
  style base {
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
