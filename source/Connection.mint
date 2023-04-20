/* A component for displaying the connection between a component and a store. */
component Connection {
  /* The exposed keys. */
  property keys : Array(String) = []

  /* The name of the store. */
  property store : String = ""

  style base {
    font-family: Source Code Pro;
    font-weight: bold;
    padding-top: 15px;
    font-size: 18px;
  }

  style name {
    display: inline;
    color: #2e894e;
  }

  style keys {
    font-weight: normal;
    padding-left: 20px;
  }

  style key {
    &:not(:last-child):after {
      content: ", ";
    }
  }

  /* Renders a key. */
  fun renderKey (key : String) : Html {
    <div::key>
      <{ key }>
    </div>
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::name>
        <{ store }>
      </div>

      <span>" exposing {"</span>

      <div::keys>
        <{ Array.map(keys, renderKey) }>
      </div>

      <div>"}"</div>
    </div>
  }
}
