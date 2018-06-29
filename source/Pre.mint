/* Component for rendering source code. */
component Pre {
  /* The code to render. */
  property code : String = ""

  style base {
    font-family: Source Code Pro;
    border: 1px dashed #DDD;
    background: #FAFAFA;
    font-size: 14px;
    padding: 10px;
    margin: 0;
  }

  fun render : Html {
    <pre::base>
      <{ code }>
    </pre>
  }
}
