/* A component for the top-level entity tab. */
component Tab {
  connect Application exposing { selectTab, tab }

  /* The type for the tab. */
  property of : Type = Type::Component

  style base {
    background: {background};
    text-decoration: none;
    align-items: center;
    padding: 0 20px;
    cursor: pointer;
    color: inherit;
    display: flex;
    height: 50px;

    &:hover {
      background: {hoverBackground};
    }

    & svg {
      filter: drop-shadow(0 1px 0 rgba(0,0,0,0.333));
      fill: currentColor;
      margin-right: 10px;
      height: 18px;
      width: 18px;
    }
  }

  style span {
    text-shadow: 0 1px 0 rgba(0,0,0,0.333);
    text-transform: uppercase;
    font-size: 14px;
  }

  /* Returns the background color of the tab. */
  get background : String {
    if (active) {
      Type.color(of)
    } else {
      "transparent"
    }
  }

  /* Returns the hovered background color of the tab. */
  get hoverBackground : String {
    if (active) {
      "linear-gradient(rgba(255, 255, 255, 0.1), rgba(255, 255," \
      " 255, 0.1)), " + background
    } else {
      "#444"
    }
  }

  /* Returns if the tab is active or not. */
  get active : Bool {
    tab == of
  }

  /* Renders the component. */
  fun render : Html {
    <a::base href={"/" + Type.path(of)}>
      <{ Type.icon(of) }>

      <span::span>
        <{ Type.title(of) }>
      </span>
    </a>
  }
}
