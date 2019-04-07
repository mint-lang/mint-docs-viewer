/* A component for displaying the connection between a component and a provider. */
component Use {
  /* The condition. */
  property condition : Maybe(String) = Maybe.nothing()

  /* The provider. */
  property provider : String = ""

  /* The data. */
  property data : String = ""

  style base {
    font-family: Source Code Pro;
    flex-direction: column;
    padding-top: 15px;
    font-size: 18px;
    display: flex;
  }

  style name {
    color: #2e894e;
  }

  style code {
    align-self: flex-start;
    margin-left: 20px;
    margin-top: 20px;
  }

  style when {
    font-family: sans-serif;
    margin-top: 20px;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::name>
        <{ provider }>
      </div>

      <div::code>
        <Pre code={data}/>
      </div>

      <If condition={Maybe.isJust(condition)}>
        <div::when>
          "only when:"
        </div>

        <div::code>
          <Pre code={Maybe.withDefault("", condition)}/>
        </div>
      </If>
    </div>
  }
}
