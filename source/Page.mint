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
    display: flex;
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

  style subscription {
    font-family: Source Code Pro;
    margin-top: 15px;
    font-size: 18px;
    color: #2e894e;
  }

  style parameters {
    font-weight: normal;
    color: #2e894e;

    &::before {
      content: "(";
      color: #333;
    }

    &::after {
      content: ")";
      color: #333;
    }
  }

  /* Renders the components. */
  fun render : Html {
    let computedProperties =
      selected.computedProperties
      |> Array.map(
        (property : ComputedProperty) : Html {
          <Entity
            key={selected.name + property.name}
            description={property.description}
            source={property.source}
            name={property.name}
            type={property.type}/>
        })

    let properties =
      selected.properties
      |> Array.map(
        (property : Property) : Html {
          <Entity
            defaultValue={property.defaultValue or ""}
            key={selected.name + property.name}
            description={property.description}
            name={property.name}
            type={property.type}/>
        })

    let methods =
      selected.functions
      |> Array.map(
        (method : Method) : Html {
          <Entity
            key={selected.name + method.name}
            description={method.description}
            arguments={method.arguments}
            source={method.source}
            name={method.name}
            type={method.type}/>
        })

    let connects =
      selected.connects
      |> Array.map(
        (item : Connect) : Html {
          <Connection
            store={item.store}
            keys={item.keys}/>
        })

    let fields =
      selected.fields
      |> Array.map(
        (item : RecordField) : Html {
          <Field
            mapping={item.mapping}
            type={item.type}
            name={item.key}/>
        })

    let states =
      selected.states
      |> Array.map(
        (item : Property) : Html {
          <Entity
            defaultValue={item.defaultValue or ""}
            key={selected.name + item.name}
            description={item.description}
            name={item.name}
            type={item.type}/>
        })

    let options =
      selected.options
      |> Array.map(
        (item : EnumOption) : Html {
          <Option
            description={item.description}
            parameters={item.parameters}
            name={item.name}/>
        })

    let uses =
      selected.uses
      |> Array.map(
        (item : Use) : Html {
          <Use
            condition={item.condition}
            provider={item.provider}
            data={item.data}/>
        })

    <div::base>
      <div::title>
        <{ selected.name }>

        <Unless condition={Array.isEmpty(selected.parameters)}>
          <div::parameters>
            <{ String.join(selected.parameters, ", ") }>
          </div>
        </Unless>
      </div>

      <div::description>
        <RawHtml content={selected.description}/>
      </div>

      <Unless condition={Array.isEmpty(connects)}>
        <div::section>"Connected Stores"</div>

        <div>
          <{ connects }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(states)}>
        <div::section>"States"</div>

        <div>
          <{ states }>
        </div>
      </Unless>

      <Unless condition={String.isEmpty(selected.subscription)}>
        <div::section>"Subscription"</div>

        <div::subscription>
          <{ selected.subscription }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(uses)}>
        <div::section>"Using Providers"</div>

        <div>
          <{ uses }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(fields)}>
        <div::section>"Fields"</div>

        <div>
          <{ fields }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(options)}>
        <div::section>"Options"</div>

        <div>
          <{ options }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(properties)}>
        <div::section>"Properties"</div>

        <div>
          <{ properties }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(computedProperties)}>
        <div::section>"Computed Properties"</div>

        <div>
          <{ computedProperties }>
        </div>
      </Unless>

      <Unless condition={Array.isEmpty(methods)}>
        <div::section>"Functions"</div>

        <div>
          <{ methods }>
        </div>
      </Unless>
    </div>
  }
}
