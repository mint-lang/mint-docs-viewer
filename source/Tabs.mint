/* A component for the top-level entity tabs. */
component Tabs {
  connect Application exposing { documentations, documentation, tab, page }

  style base {
    border-bottom: 5px solid {color};
    font-weight: bold;
    background: #333;
    display: flex;
    color: #EEE;
  }

  /* Returns whether the dashboard is active or not. */
  get isDashboard : Bool {
    page == Page::Dashboard
  }

  /* Returns the color of the active tab, so the bottom border can match it. */
  get color : String {
    case (page) {
      Page::Dashboard => "#666"
      Page::Package => "#666"
      => Type.color(tab)
    }
  }

  /* Returns the icon for the dashboard. */
  get dashboardIcon : Html {
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      height="24"
      width="24">

      <path
        d={
          "M12 2c-6.627 0-12 5.373-12 12 0 2.583.816 5.042 2.205 7h" \
          "19.59c1.389-1.958 2.205-4.417 2.205-7 0-6.627-5.373-12-1" \
          "2-12zm-.758 2.14c.256-.02.51-.029.758-.029s.502.01.758.0" \
          "29v3.115c-.252-.027-.506-.042-.758-.042s-.506.014-.758.0" \
          "42v-3.115zm-5.763 7.978l-2.88-1.193c.157-.479.351-.948.5" \
          "81-1.399l2.879 1.192c-.247.444-.441.913-.58 1.4zm1.216-2" \
          ".351l-2.203-2.203c.329-.383.688-.743 1.071-1.071l2.203 2" \
          ".203c-.395.316-.754.675-1.071 1.071zm.793-4.569c.449-.23" \
          "1.919-.428 1.396-.586l1.205 2.875c-.485.141-.953.338-1.3" \
          "96.585l-1.205-2.874zm1.408 13.802c.019-1.151.658-2.15 1." \
          "603-2.672l1.501-7.041 1.502 7.041c.943.522 1.584 1.521 1" \
          ".603 2.672h-6.209zm4.988-11.521l1.193-2.879c.479.156.948" \
          ".352 1.399.581l-1.193 2.878c-.443-.246-.913-.44-1.399-.5" \
          "8zm2.349 1.217l2.203-2.203c.383.329.742.688 1.071 1.071l" \
          "-2.203 2.203c-.316-.396-.675-.755-1.071-1.071zm2.259 3.3" \
          "2c-.147-.483-.35-.95-.603-1.39l2.86-1.238c.235.445.438.9" \
          "12.602 1.39l-2.859 1.238z"
        }/>

    </svg>
  }

  /* Renders the component. */
  fun render : Html {
    <div::base>
      <Tab
        active={page == Page::Dashboard}
        icon={dashboardIcon}
        color="#666"
        link="/"/>

      <If condition={documentation.name != ""}>
        <Tab
          active={page == Page::Package}
          link={"/" + documentation.name}
          title={documentation.name}
          icon={Icons.package}
          color="#666"/>
      </If>

      <Unless condition={Array.isEmpty(documentation.components)}>
        <EntityTab of={Type::Component}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.modules)}>
        <EntityTab of={Type::Module}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.stores)}>
        <EntityTab of={Type::Store}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.providers)}>
        <EntityTab of={Type::Provider}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.records)}>
        <EntityTab of={Type::Record}/>
      </Unless>

      <Unless condition={Array.isEmpty(documentation.enums)}>
        <EntityTab of={Type::Enum}/>
      </Unless>
    </div>
  }
}
