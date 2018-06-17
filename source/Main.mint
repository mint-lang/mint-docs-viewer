component Main {
  connect Documentation.Store exposing { load, components, stores, selected }

  fun componentDidMount : Void {
    load()
  }

  style base {
    font-family: sans-serif;
    flex-direction: column;
    min-height: 100vh;
    display: flex;
    color: #333;
  }

  style content {
    display: flex;
    flex: 1;
  }

  get content : Html {
    <Documentation.Content/>
  }

  fun render : Html {
    <div::base>
      <Documentation.Tabs/>

      <div::content>
        <Documentation.Sidebar/>
        <{ content }>
      </div>
    </div>
  }
}
