component Markdown {
  property content : String = ""

  get html : String {
    `
    (() => {
      let reader = new commonmark.Parser()
      let writer = new commonmark.HtmlRenderer()
      let parsed = reader.parse(this.content)
      let result = writer.render(parsed)

      return result
    })()
    `
  }

  style base {
    & > *:first-child {
      margin-top: 0;
    }

    & > *:last-child {
      margin-bottom: 0;
    }

    & pre {
      font-family: Source Code Pro;
      border: 1px dashed #EEE;
      font-size: 14px;
      padding: 10px;
    }
  }

  fun render : Html {
    <div::base dangerouslySetInnerHTML={`{__html: this.html}`}/>
  }
}
