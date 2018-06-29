/* A component for the sidebar header. */
component Sidebar.Header {
  /* The text to render. */
  property text : String = ""

  style base {
    text-transform: uppercase;
    margin-bottom: 10px;
    font-weight: bold;
    font-size: 14px;
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <{ text }>
    </div>
  }
}
