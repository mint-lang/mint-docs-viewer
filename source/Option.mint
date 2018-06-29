/* A component to render the options of an enum. */
component Option {
  /* The name of the option. */
  property name : String = ""

  style base {
    font-family: Source Code Pro;
    flex-direction: column;
    font-weight: bold;
    padding-top: 15px;
    font-size: 18px;
    display: flex;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ name }>
    </div>
  }
}
