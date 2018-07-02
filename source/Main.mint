/* The main component. */
component Main {
  connect Application exposing { selected, status, load, page }

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

  /* Returns the content to render. */
  get main : Html {
    <div::base>
      <Tabs/>

      <{ content }>
    </div>
  }

  get content : Html {
    case (page) {
      Page::Dashboard => <Dashboard/>
      Page::Package => <Package/>

      Page::Entity =>
        <div::content>
          <Sidebar/>
          <Page/>
        </div>
    }
  }

  /* Renders the component. */
  fun render : Html {
    case (status) {
      Status::JsonError => <Error content="Could not parse the documentation json!"/>
      Status::DecodeError => <Error content="Could not decode the documentation!"/>
      Status::HttpError => <Error content="Could not load the documentation!"/>
      Status::Initial => <div/>
      Status::Ok => main
    }
  }
}
