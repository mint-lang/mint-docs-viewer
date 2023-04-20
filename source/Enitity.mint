/* A component for rendering an entity (function, property, etc..). */
component Entity {
  /* The desctiption in raw HTML format, if nothing it will not be rendered. */
  property description : Maybe(String) = Maybe.nothing()

  /* The arguments for a function, if empty they will not be rendered. */
  property arguments : Array(Argument) = []

  /* The default value for a property, if empty it will not be rendered. */
  property defaultValue : String = ""

  /* The source of the entity, if empty it will not be rendered. */
  property source : String = ""

  /* The name of the enity. */
  property name : String = ""

  /* The type signature of the enity. */
  property type : Maybe(String) = Maybe::Nothing

  style definition {
    font-family: Source Code Pro;
    white-space: nowrap;
    align-items: center;
    font-size: 18px;
    display: flex;
  }

  style name {
    align-items: center;
    font-weight: bold;
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

  style base {
    padding: 15px 0;

    + * {
      border-top: 1px dashed #DDD;
    }
  }

  style arguments {
    display: flex;

    &:before {
      content: "(";
      opacity: 0.75;
    }

    &:after {
      content: ")";
      opacity: 0.75;
    }
  }

  style argument {
    + *:before {
      content: ", ";
    }
  }

  style description {
    padding: 18px 0;
    padding-left: 20px;
    opacity: 0.8;
  }

  style default {
    align-items: center;
    display: flex;

    &:before {
      font-weight: 300;
      margin: 0 5px;
      content: "=";
      color: #999;
    }
  }

  /* Renders the given argument. */
  fun renderArgument (argument : Argument) : Html {
    <div::argument>
      <strong>
        <{ argument.name }>
      </strong>

      <span::type>
        <{ argument.type }>
      </span>
    </div>
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <div::definition>
        <div::name>
          <{ name }>
        </div>

        <Unless condition={Array.isEmpty(arguments)}>
          <div::arguments>
            <{ Array.map(arguments, renderArgument) }>
          </div>
        </Unless>

        case (type) {
          Maybe::Just(value) =>
            <div::type>
              <{ value }>
            </div>

          => <></>
        }

        <Unless condition={String.isEmpty(defaultValue)}>
          <div::default>
            <Pre code={defaultValue}/>
          </div>
        </Unless>
      </div>

      <If condition={Maybe.isJust(description)}>
        <div::description>
          <RawHtml content={description or ""}/>
        </div>
      </If>

      <Unless condition={String.isEmpty(source)}>
        <Source code={source}/>
      </Unless>
    </div>
  }
}
