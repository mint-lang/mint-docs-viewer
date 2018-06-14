component Documentation.Sidebar.Item {
  connect Documentation.Store exposing { select }

  property type : Documentation.Type = Documentation.Type::Component
  property name : String = ""

  style base {
    text-decoration: none;
    align-items: center;
    margin-bottom: 5px;
    cursor: pointer;
    color: inherit;
    display: flex;

    &:hover span {
      text-decoration: underline;
    }
  }

  style span {
    line-height: 13px;
  }

  style badge {
    background-color: {badgeColor};
    justify-content: center;
    display: inline-flex;
    align-items: center;
    margin-right: 7px;
    border-radius: 2px;
    font-weight: bold;
    font-size: 12px;
    height: 20px;
    width: 20px;
    color: #FFF;
  }

  get badgeColor : String {
    case (type) {
      Documentation.Type::Component => "#369e58"
      Documentation.Type::Module => "#be08d0"
      Documentation.Type::Store => "#d02e2e"
    }
  }

  fun render : Html {
    <div::base onClick={\event : Html.Event => select(name)}>
      <div::badge>
        <{ "C" }>
      </div>

      <span::span>
        <{ name }>
      </span>
    </div>
  }
}
