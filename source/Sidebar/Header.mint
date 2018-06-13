component Documentation.Sidebar.Header {
  property text : String = ""

  style base {
    text-transform: uppercase;
    margin-bottom: 10px;
    font-weight: bold;
    font-size: 14px;
  }

  fun render : Html {
    <div::base>
      <{ text }>
    </div>
  }
}
