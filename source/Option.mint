/* A component to render the options of an enum. */
component Option {
  /* The desctiption in raw HTML format, if nothing it will not be rendered. */
  property description : Maybe(String) = Maybe.nothing()

  /* The parameters of the option. */
  property parameters : Array(String) = []

  /* The name of the option. */
  property name : String = ""

  style base {
    flex-direction: column;
    padding-top: 15px;
    display: flex;
  }

  style name {
    font-family: Source Code Pro;
    font-weight: bold;
    font-size: 18px;
    display: flex;
  }

  style description {
    padding: 20px 0;
    padding-left: 20px;
    opacity: 0.8;
  }

  style parameters {
    font-weight: normal;
    color: #2e894e;

    &::before {
      content: "(";
      color: #333;
    }

    &::after {
      content: ")";
      color: #333;
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::name>
        <{ name }>

        <Unless condition={Array.isEmpty(parameters)}>
          <div::parameters>
            <{ String.join(parameters, ", ") }>
          </div>
        </Unless>
      </div>

      <If condition={Maybe.isJust(description)}>
        <div::description>
          <RawHtml content={description or ""}/>
        </div>
      </If>
    </div>
  }
}
