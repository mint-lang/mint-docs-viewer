/* A component to render a record definitions field. */
component Field {
  /* The mapping of the field. */
  property mapping : Maybe(String) = Maybe.nothing()

  /* The type of the field. */
  property type : String = ""

  /* The name of the field. */
  property name : String = ""

  style base {
    font-family: Source Code Pro;
    padding-top: 15px;
    font-size: 18px;
    display: flex;
  }

  style type {
    color: #2e894e;

    &:before {
      font-weight: 300;
      margin: 0 5px;
      content: ":";
      color: #999;
    }
  }

  style key {
    font-weight: bold;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::key>
        <{ name }>
      </div>

      <div::type>
        <{ type }>
      </div>
    </div>
  }
}
