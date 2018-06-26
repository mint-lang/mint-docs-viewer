component Documentation.Entity {
  property description : Maybe(String) = Maybe.nothing()
  property arguments : Array(Argument) = []
  property defaultValue : String = ""
  property source : String = ""
  property name : String = ""
  property type : String = ""

  style definition {
    font-family: Source Code Pro;
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

    & + * {
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
    & + *:before {
      content: ", ";
    }
  }

  style description {
    padding: 20px 0;
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

  fun render : Html {
    <div::base>
      <div::definition>
        <div::name>
          <{ name }>
        </div>

        <Unless condition={Array.isEmpty(arguments)}>
          <div::arguments>
            <{ argumentItems }>
          </div>
        </Unless>

        <div::type>
          <{ type }>
        </div>

        <Unless condition={String.isEmpty(defaultValue)}>
          <div::default>
            <Documentation.Pre code={defaultValue}/>
          </div>
        </Unless>
      </div>

      <If condition={Maybe.isJust(description)}>
        <div::description>
          <{ <RawHTML content={Maybe.withDefault("", description)}/> }>
        </div>
      </If>

      <Unless condition={String.isEmpty(source)}>
        <Documentation.Source code={source}/>
      </Unless>
    </div>
  } where {
    argumentItems =
      arguments
      |> Array.map(
        \argument : Argument =>
          <div::argument>
            <strong>
              <{ argument.name }>
            </strong>

            <span::type>
              <{ argument.type }>
            </span>
          </div>)
  }
}
