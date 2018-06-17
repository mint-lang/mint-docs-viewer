component Documentation.Content {
  connect Documentation.Store exposing { selected }

  style base {
    padding: 30px;
    flex: 1;
  }

  style title {
    font-size: 30px;
  }

  fun render : Html {
    <div::base>
      <div::title>
        <{ selected.name }>
      </div>

      <{ methods }>
    </div>
  } where {
    methods =
      selected.functions
      |> Array.map(
        \method : Method =>
          <Documentation.Entity
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
    padding: 20px 0;

    & + * {
      border-top: 1px dashed #DDD;
    }
  }

  style code {
    align-items: center;
    display: flex;
  }

  style arguments {
    margin-left: 10px;
    display: flex;

    &:before {
      content: "(";
    }

    &:after {
      content: ")";
    }
  }

  style argument {
    & + *:before {
      content: ", ";
    }
  }

  get code : Html {
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24">

      <path
        d={
          "M24 10.935v2.131l-8 3.947v-2.23l5.64-2.783-5.64-2.79v-2." \
          "223l8 3.948zm-16 3.848l-5.64-2.783 5.64-2.79v-2.223l-8 3" \
          ".948v2.131l8 3.947v-2.23zm7.047-10.783h-2.078l-4.011 16h" \
          "2.073l4.016-16z"
        }/>

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

      <div::code onClick={toggleSource}>
        <{ code }>

        <div>
          <{ "Show source " }>
        </div>
      </div>

      <{
        if (state.sourceShown) {
          <pre>
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

            <span>
              <{ argument.type }>
            </span>
          </div>)
  }
}
