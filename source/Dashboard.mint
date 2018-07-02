component Dashboard {
  connect Application exposing { documentation, documentations }

  fun render : Html {
    <div>
      <{ "Dashboard" }>
      <{ packages }>
    </div>
  } where {
    packages =
      documentations
      |> Array.map(\item : Documentation => item.name)
      |> Array.map(
        \name : String =>
          <a href={"/" + name + "/component"}>
            <{ name }>
          </a>)
  }
}
