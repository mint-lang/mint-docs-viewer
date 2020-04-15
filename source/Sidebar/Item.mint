/* Renders a sidebar item. */
component Sidebar.Item {
  connect Application exposing { tab, documentation }

  /* The type of the item. */
  property type : Type = Type::Component

  /* The text to render. */
  property text : String = ""

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
    background-color: #{Type.color(tab)};
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

  /* Renders the component. */
  fun render : Html {
    <a::base href={"/" + documentation.name + "/" + Type.path(tab) + "/" + text}>
      <div::badge>
        <{ Type.char(tab) }>
      </div>

      <span::span>
        <{ text }>
      </span>
    </a>
  }
}
