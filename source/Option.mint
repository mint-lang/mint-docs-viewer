/* A component to render the options of an enum. */
component Option {
  /* The desctiption in raw HTML format, if nothing it will not be rendered. */
  property description : Maybe(String) = Maybe.nothing()

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
  }

  style description {
    padding: 20px 0;
    padding-left: 20px;
    opacity: 0.8;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::name>
        <{ name }>
      </div>

      <If condition={Maybe.isJust(description)}>
        <div::description>
          <RawHtml content={Maybe.withDefault("", description)}/>
        </div>
      </If>
    </div>
  }
}
