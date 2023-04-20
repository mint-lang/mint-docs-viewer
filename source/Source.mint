/* Component for rendering the source code of entities. */
component Source {
  /* Whether or not the source is shown. */
  state shown : Bool = false

  /* The code to render. */
  property code : String = ""

  /* The base style. */
  style base {
    text-transform: uppercase;
    align-items: center;
    margin-top: 10px;
    font-size: 10px;
    cursor: pointer;
    display: flex;
    opacity: 0.33;

    &:hover {
      opacity: 1;
    }
  }

  /* The style for the chevron icon. */
  style icon {
    transform: #{transform};
    position: relative;
    fill: currentColor;
    margin-right: 5px;
    top: -1px;
  }

  /* The style for the code block. */
  style code {
    margin-top: 10px;
  }

  /* The chevron icon. */
  get icon : Html {
    <svg::icon
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      height="9"
      width="9">

      <path d="M5 3l3.057-3 11.943 12-11.943 12-3.057-3 9-9z"/>

    </svg>
  }

  /* The text to show based on the state. */
  get text : String {
    if (shown) {
      "Hide source "
    } else {
      "Show source"
    }
  }

  /* The value for the transform property, it is used by the icon style. */
  get transform : String {
    if (shown) {
      "rotate(90deg)"
    } else {
      ""
    }
  }

  /* Handles the click event, and toggles the state. */
  fun toggle (event : Html.Event) : Promise(Void) {
    next { shown: !shown }
  }

  /* Renders the component. */
  fun render : Html {
    <div>
      <div::base onClick={toggle}>
        <{ icon }>

        <div>
          <{ text }>
        </div>
      </div>

      <If condition={shown}>
        <div::code>
          <Pre code={code}/>
        </div>
      </If>
    </div>
  }
}
