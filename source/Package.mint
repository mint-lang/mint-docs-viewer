/* Component to render package details. */
component Package {
  connect Application exposing { documentation }

  style base {
    padding: 30px;
  }

  style title {
    border-bottom: 3px solid #EEE;
    padding-bottom: 5px;
    margin-bottom: 20px;
    font-size: 36px;
  }

  style package {
    display: block;
  }

  style subtitle {
    margin-bottom: 5px;
    font-size: 20px;
  }

  /* Renders the component. */
  fun render : Html {
    let dependencies =
      documentation.dependencies
      |> Array.map(
        (item : Dependency) : Html {
          <Dependency
            constraint={item.constraint}
            repository={item.repository}
            name={item.name}/>
        })

    <div::base>
      <div::title>
        <{ documentation.name }>
      </div>

      <Unless condition={Array.isEmpty(dependencies)}>
        <div::subtitle>"Dependencies"</div>

        <div>
          <{ dependencies }>
        </div>
      </Unless>
    </div>
  }
}
