record Documentation.Entity.State {
  sourceShown : Bool
}

component Documentation.Entity {
  property description : Maybe(String) = Maybe.nothing()
  property arguments : Array(Argument) = []
  property defaultValue : String = ""
  property source : String = ""
  property name : String = ""
  property type : String = ""

  state : Documentation.Entity.State { sourceShown = false }

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

  style code {
    text-transform: uppercase;
    align-items: center;
    margin-top: 10px;
    font-size: 10px;
    cursor: pointer;
    display: flex;
    opacity: 0.33;

    &:hover {
      opacity: 1;
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

  style code-icon {
    transform: {codeTransform};
    position: relative;
    fill: currentColor;
    margin-right: 5px;
    top: -1px;
  }

  style pre {
    font-family: Source Code Pro;
    border: 1px dashed #DDD;
    background: #FAFAFA;
    font-size: 14px;
    padding: 10px;

    margin: 0;
    margin-top: 10px;
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

    & pre {
      margin: 0;
    }
  }

  get codeTransform : String {
    if (state.sourceShown) {
      "rotate(90deg)"
    } else {
      ""
    }
  }

  get showSourceText : String {
    if (state.sourceShown) {
      "Hide source "
    } else {
      "Show source"
    }
  }

  get code : Html {
    <svg::code-icon
      xmlns="http://www.w3.org/2000/svg"
      width="9"
      height="9"
      viewBox="0 0 24 24">

      <path d="M5 3l3.057-3 11.943 12-11.943 12-3.057-3 9-9z"/>

    </svg>
  }

  fun toggleSource (event : Html.Event) : Void {
    next { state | sourceShown = !state.sourceShown }
  }

  fun render : Html {
    <div::base>
      <div::definition>
        <div::name>
          <{ name }>
        </div>

        <{
          if (Array.isEmpty(arguments)) {
            Html.empty()
          } else {
            <div::arguments>
              <{ argumentItems }>
            </div>
          }
        }>

        <div::type>
          <{ type }>
        </div>

        <{
          if (String.isEmpty(defaultValue)) {
            Html.empty()
          } else {
            <div::default>
              <pre::pre>
                <{ defaultValue }>
              </pre>
            </div>
          }
        }>
      </div>

      <{
        if (Maybe.isJust(description)) {
          <div::description>
            <{ <Markdown content={Maybe.withDefault("", description)}/> }>
          </div>
        } else {
          Html.empty()
        }
      }>

      <{
        if (String.isEmpty(source)) {
          Html.empty()
        } else {
          <div::code onClick={toggleSource}>
            <{ code }>

            <div>
              <{ showSourceText }>
            </div>
          </div>
        }
      }>

      <{
        if (state.sourceShown) {
          <pre::pre>
            <{ source }>
          </pre>
        } else {
          Html.empty()
        }
      }>
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
