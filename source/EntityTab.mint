/* A component to render a tab for a `Type`. */
component EntityTab {
  connect Application exposing { tab, documentation, page }

  /* The type for the tab. */
  property of : Type = Type::Component

  /* Renders the component. */
  fun render : Html {
    <Tab
      link={"/" + documentation.name + "/" + Type.path(of)}
      title={Type.title(of)}
      color={Type.color(of)}
      icon={Type.icon(of)}
      active={of == tab && page == Page::Entity}/>
  }
}
