/* A component to render raw HTML. */
component RawHtml {
  /* The raw HTML to render. */
  property content : String = ""

  style base {
    & *:first-child {
      margin-top: 0;
    }

    & *:last-child {
      margin-bottom: 0;
    }

    & li {
      line-height: 2;
    }

    & pre,
    & p code,
    & li code {
      font-family: Source Code Pro;
      background: #F2F2F2;
      border-radius: 2px;
      padding: 5px 7px;
      font-size: 14px;
      margin: 0;
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div::base dangerouslySetInnerHTML={`{__html: this.content}`}/>
  }
}
