/* A component to render the state of a component. */
component State {
  /* The type of the state. */
  property type : String = ""

  /* The initial value. */
  property defaultValue : String = ""

  style base {
    font-family: Source Code Pro;
    flex-direction: column;
    padding-top: 15px;
    font-size: 18px;
    display: flex;
  }

  style type {
    align-items: center;
    color: #2e894e;
    display: flex;
  }

  style equals {
    margin-left: 10px;
    font-weight: 300;
    margin-top: 5px;
    content: "=";
    color: #999;
  }

  style code {
    align-self: flex-start;
    margin-left: 20px;
    margin-top: 20px;
    display: block;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::type>
        <{ type }>

        <div::equals>"="</div>
      </div>

      <div::code>
        <Pre code={defaultValue}/>
      </div>
    </div>
  }
}
