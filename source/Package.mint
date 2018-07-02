component Dependency {
  property repository : String = ""
  property constraint : String = ""
  property name : String = ""

  fun render : Html {
    <div>
      <div>
        <{ name }>
      </div>

      <div>
        <{ constraint }>
      </div>

      <div>
        <{ repository }>
      </div>
    </div>
  }
}

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

  fun render : Html {
    <div::base>
      <div::title>
        <{ documentation.name }>
      </div>

      <div>
        <{ dependencies }>
      </div>
    </div>
  } where {
    dependencies =
      documentation.dependencies
      |> Array.map(
        \item : Dependency =>
          <Dependency
            constraint={item.constraint}
            repository={item.repository}
            name={item.name}/>)
  }
}
