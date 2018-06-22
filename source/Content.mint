component If {
  property children : Array(Html) = []
  property condition : Bool = true

  fun render : Array(Html) {
    if (condition) {
      children
    } else {
      []
    }
  }
}

component Unless {
  property children : Array(Html) = []
  property condition : Bool = true

  fun render : Array(Html) {
    if (!condition) {
      children
    } else {
      []
    }
  }
}

component Documentation.Content {
  connect Documentation.Store exposing { selected }

  style base {
    padding: 30px;
    flex: 1;
  }

  style title {
    border-bottom: 2px solid #EEE;
    padding-bottom: 10px;
    font-size: 30px;
  }

  style description {
    margin-top: 20px;
    opacity: 0.8;
  }

  style section {
    border-bottom: 1px solid #EEE;
    text-transform: uppercase;
    padding-bottom: 10px;
    font-weight: 600;
    margin-top: 40px;
    font-size: 14px;
    opacity: 0.6;
  }

  fun render : Html {
    <div::base>
      <div::title>
        <{ selected.name }>
      </div>

      <div::description>
        <Markdown content={selected.description}/>
      </div>

      <Unless condition={Array.isEmpty(properties)}>
        <div::section>
          <{ "Properties" }>
        </div>

        <div>
          <{ properties }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(methods)}>
        <div::section>
          <{ "Functions" }>
        </div>

        <div>
          <{ methods }>
        </div>
      </Unless>
    </div>
  } where {
    properties =
      selected.properties
      |> Array.sortBy(\property : Property => property.name)
      |> Array.map(
        \property : Property =>
          <Documentation.Entity
            defaultValue={property.defaultValue}
            name={property.name}
            type={property.type}/>)

    methods =
      selected.functions
      |> Array.map(
        \method : Method =>
          <Documentation.Entity
            description={method.description}
            arguments={method.arguments}
            source={method.source}
            name={method.name}
            type={method.type}/>)
  }
}
