component RawHTML {
  property content : String = ""

  style base {
    & *:first-child {
      margin-top: 0;
    }

    & *:last-child {
      margin-bottom: 0;
    }
  }

  fun render : Html {
    <div::base dangerouslySetInnerHTML={`{__html: this.content}`}/>
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
        <RawHTML content={selected.description}/>
      </div>

      <Unless condition={Array.isEmpty(properties)}>
        <div::section>
          <{ "Properties" }>
        </div>

        <div>
          <{ properties }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(computedProperties)}>
        <div::section>
          <{ "Computed Properties" }>
        </div>

        <div>
          <{ computedProperties }>
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
    computedProperties =
      selected.computedProperties
      |> Array.map(
        \method : ComputedProperty =>
          <Documentation.Entity
            description={method.description}
            source={method.source}
            name={method.name}
            type={method.type}/>)

    properties =
      selected.properties
      |> Array.sortBy(\property : Property => property.name)
      |> Array.map(
        \property : Property =>
          <Documentation.Entity
            defaultValue={property.defaultValue}
            description={property.description}
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
