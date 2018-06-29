component Field {
  property mapping : Maybe(String) = Maybe.nothing()
  property type : String = ""
  property name : String = ""

  style base {
    font-family: Source Code Pro;
    padding-top: 15px;
    font-size: 18px;
    display: flex;
  }

  style type {
    color: #2e894e;

    &:before {
      font-weight: 300;
      margin: 0 5px;
      content: ":";
      color: #999;
    }
  }

  style key {
    font-weight: bold;
  }

  fun render : Html {
    <div::base>
      <div::key>
        <{ name }>
      </div>

      <div::type>
        <{ type }>
      </div>
    </div>
  }
}

/*
A component for rendering an top-level enitity (module, store, etc..).

It can render:
- computed properties
- properties
- functions
- styles
*/
component Page {
  connect Application exposing { selected }

  style base {
    flex: 1;
    padding: 30px;
    padding-bottom: 150px;
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

  /* Renders the components. */
  fun render : Html {
    <div::base>
      <div::title>
        <{ selected.name }>
      </div>

      <div::description>
        <RawHtml content={selected.description}/>
      </div>

      <Unless condition={Array.isEmpty(connects)}>
        <div::section>
          <{ "Connected Stores" }>
        </div>

        <div>
          <{ connects }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(fields)}>
        <div::section>
          <{ "Fields" }>
        </div>

        <div>
          <{ fields }>
        </div>
      </Unless>

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
        \property : ComputedProperty =>
          <Entity
            key={selected.name + property.name}
            description={property.description}
            source={property.source}
            name={property.name}
            type={property.type}/>)

    properties =
      selected.properties
      |> Array.map(
        \property : Property =>
          <Entity
            key={selected.name + property.name}
            defaultValue={property.defaultValue}
            description={property.description}
            name={property.name}
            type={property.type}/>)

    methods =
      selected.functions
      |> Array.map(
        \method : Method =>
          <Entity
            key={selected.name + method.name}
            description={method.description}
            arguments={method.arguments}
            source={method.source}
            name={method.name}
            type={method.type}/>)

    connects =
      selected.connects
      |> Array.map(
        \item : Connect =>
          <Connection
            store={item.store}
            keys={item.keys}/>)

    fields =
      selected.fields
      |> Array.map(
        \item : RecordField =>
          <Field
            mapping={item.mapping}
            type={item.type}
            name={item.key}/>)
  }
}
