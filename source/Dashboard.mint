/* Dashboard for the documentation. */
component Dashboard {
  connect Application exposing { documentations }

  style base {
    padding: 30px;
  }

  style package {
    align-items: center;
    font-size: 18px;
    padding: 10px 0;
    color: #2e894e;
    display: flex;

    svg {
      fill: currentColor;
      margin-right: 5px;
      height: 20px;
      width: 20px;
    }
  }

  style title {
    border-bottom: 3px solid #EEE;
    padding-bottom: 5px;
    margin-bottom: 20px;
    font-size: 36px;
  }

  /* Renders the component. */
  fun render : Html {
    let packages =
      documentations
      |> Array.map((item : Documentation) : String { item.name })
      |> Array.map(
        (name : String) : Html {
          <a::package href={"/" + name}>
            <{ Icons.package() }>
            <{ name }>
          </a>
        })

    <div::base>
      <div::title>"Dashboard"</div>

      <div>
        <{ packages }>
      </div>
    </div>
  }
}
