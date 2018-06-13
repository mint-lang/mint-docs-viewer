component Documentation.Content {
  property title : String = ""

  style base {

  }

  style title {

  }

  fun render : Html {
    <div::base>
      <div::title>
        <{ title }>
      </div>
    </div>
  }
}
