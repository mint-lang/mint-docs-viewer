/* Component for displaying a dependency of a package. */
component Dependency {
  /* The repository of the dependency. */
  property repository : String = ""

  /* The constaint of the dependency. */
  property constraint : String = ""

  /* The name of the dependency. */
  property name : String = ""

  style base {
    display: flex;
  }

  style id {
    font-size: 20px;
    display: flex;
  }

  style name {
    font-weight: bold;
  }

  style repository {
    opacity: 0.5;
  }

  style constraint {
    &:before {
      margin: 0 5px;
      content: "-";
    }
  }

  /* Renders the component. */
  fun render : Html {
    <div>
      <div::id>
        <div::name>
          <{ name }>
        </div>

        <div::constraint>
          <{ constraint }>
        </div>
      </div>

      <div::repository>
        <{ repository }>
      </div>
    </div>
  }
}
