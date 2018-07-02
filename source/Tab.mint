/* A component to render a tab. */
component Tab {
  /* The icon on the left. */
  property icon : Html = Html.empty()

  /* Whether or not the tab is active. */
  property active : Bool = false

  /* The text to display. */
  property title : String = ""

  /* The active color. */
  property color : String = ""

  /* The url to link to. */
  property link : String = ""

  style base {
    background: {background};
    text-decoration: none;
    align-items: center;
    padding: 0 15px;
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
      height: 18px;
      width: 18px;
    }
  }

  style span {
    text-shadow: 0 1px 0 rgba(0,0,0,0.333);
    text-transform: uppercase;
    margin-left: 10px;
    font-size: 14px;
  }

  /* Returns the background color of the tab. */
  get background : String {
    if (active) {
      color
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

  /* Renders the component. */
  fun render : Html {
    <a::base href={link}>
      <{ icon }>

      <If condition={title != ""}>
        <span::span>
          <{ title }>
        </span>
      </If>
    </a>
  }
}
