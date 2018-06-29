/* The main component. */
component Main {
  connect Application exposing { components, selected, status, stores, load }

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
  get content : Html {
    <div::base>
      <Tabs/>

      <div::content>
        <Sidebar/>
        <Page/>
      </div>
    </div>
  }

  /* Renders the component. */
  fun render : Html {
    case (status) {
      Status::JsonError => <Error content="Could not parse the documentation json!"/>
      Status::DecodeError => <Error content="Could not decode the documentation!"/>
      Status::HttpError => <Error content="Could not load the documentation!"/>
      Status::Initial => <div/>
      Status::Ok => content
    }
  }
}
