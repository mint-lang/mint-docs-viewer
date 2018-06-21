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

  fun render : Html {
    <div::base>
      <div::title>
        <{ selected.name }>
      </div>

      <div::description>
        <Markdown content={selected.description}/>
      </div>

      <{ methods }>
    </div>
  } where {
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

record Documentation.Entity.State {
  sourceShown : Bool
}

component Documentation.Entity {
  property description : Maybe(String) = Maybe.nothing()
  property arguments : Array(Argument) = []
  property source : String = ""
  property name : String = ""
  property type : String = ""

  state : Documentation.Entity.State { sourceShown = false }

  style definition {
    font-family: Source Code Pro;
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
    border: 1px solid #EEE;
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

        <div::arguments>
          <{ argumentItems }>
        </div>

        <div::type>
          <{ type }>
        </div>
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

      <div::code onClick={toggleSource}>
        <{ code }>

        <div>
          <{ showSourceText }>
        </div>
      </div>

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
