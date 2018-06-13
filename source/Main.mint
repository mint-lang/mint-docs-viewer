component Main {
  connect Documentation.Store exposing { load, components, stores, selected }

  fun componentDidMount : Void {
    load()
  }

  style base {
    font-family: sans-serif;
    min-height: 100vh;
    display: flex;
  }

  get content : Html {
    <Documentation.Content/>
  }

  fun render : Html {
    <div::base>
      <Documentation.Sidebar/>
      <{ content }>
    </div>
  }
}
