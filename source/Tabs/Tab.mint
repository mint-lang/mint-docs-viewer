component Documentation.Tab {
  connect Documentation.Store exposing { nameOf, selectTab, tab, entityColor }

  property of : Documentation.Type = Documentation.Type::Component

  style base {
    background: {background};
    text-decoration: none;
    align-items: center;
    padding: 0 20px;
    cursor: pointer;
    color: inherit;
    display: flex;
    height: 50px;

    &:hover {
      background: {hoverBackground};
    }
  }

  style icon {
    fill: currentColor;
    margin-right: 10px;
    height: 18px;
    width: 18px;
  }

  style span {
    text-transform: uppercase;
    font-size: 14px;
  }

  get background : String {
    if (active) {
      entityColor
    } else {
      "transparent"
    }
  }

  get hoverBackground : String {
    if (active) {
      "linear-gradient(rgba(255, 255, 255, 0.1), rgba(255, 255," \
      " 255, 0.1)), " + background
    } else {
      "#444"
    }
  }

  get active : Bool {
    tab == of
  }

  get icon : Html {
    case (of) {
      Documentation.Type::Component =>
        <svg::icon
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          height="24"
          width="24">

          <path
            d={
              "M4.759 5.753h-.013v.958c-.035 1.614 4.405 1.618 4.351 0v" \
              "-.957c-.129-1.528-4.226-1.536-4.338-.001zm3.545.147c0 .3" \
              "14-.614.571-1.37.571-.755 0-1.37-.256-1.37-.571s.615-.57" \
              " 1.37-.57c.756 0 1.37.256 1.37.57zm-8.304.179l.009.005-." \
              "009-.019 11.5-6.065 11.5 6.142v5.231l-11 5.798v-5.311l9." \
              "864-5.19-10.367-5.517-10.331 5.454 9.834 5.229v5.331l-11" \
              "-5.858v-5.23zm23 6.434v5.813l-11 5.674v-5.689l11-5.798zm" \
              "-13.692-3.37c-.035 1.615 4.406 1.618 4.351 0v-.957c-.129" \
              "-1.528-4.225-1.536-4.337-.001h-.014v.958zm2.188-1.381c.7" \
              "55 0 1.37.255 1.37.57 0 .314-.615.57-1.37.57s-1.37-.255-" \
              "1.37-.57c0-.315.615-.57 1.37-.57zm2.162-3.354v-.956c-.13" \
              "-1.527-4.225-1.535-4.337-.001h-.013v.957c-.036 1.615 4.4" \
              "06 1.618 4.35 0zm-2.161-1.381c.754 0 1.37.256 1.37.571 0" \
              " .314-.616.571-1.37.571-.756 0-1.37-.257-1.37-.571 0-.31" \
              "4.614-.571 1.37-.571zm6.712 3.684v-.957c-.13-1.528-4.226" \
              "-1.536-4.336-.001h-.014v.958c-.037 1.615 4.405 1.618 4.3" \
              "5 0zm-3.532-.81c0-.314.615-.57 1.37-.57.756 0 1.371.256 " \
              "1.371.57s-.615.57-1.371.57c-.755 0-1.37-.256-1.37-.57zm-" \
              "3.677 12.408v5.691l-11-5.673v-5.875l11 5.857z"
            }/>

        </svg>

      Documentation.Type::Module =>
        <svg::icon
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          height="24"
          width="24">

          <path
            d={
              "M12 0l-11 6v12.131l11 5.869 11-5.869v-12.066l-11-6.065zm" \
              "7.91 6.646l-7.905 4.218-7.872-4.294 7.862-4.289 7.915 4." \
              "365zm-16.91 1.584l8 4.363v8.607l-8-4.268v-8.702zm10 12.9" \
              "7v-8.6l8-4.269v8.6l-8 4.269zm6.678-5.315c.007.332-.256.6" \
              "05-.588.612-.332.007-.604-.256-.611-.588-.006-.331.256-." \
              "605.588-.612.331-.007.605.256.611.588zm-2.71-1.677c-.332" \
              ".006-.595.28-.588.611.006.332.279.595.611.588s.594-.28.5" \
              "88-.612c-.007-.331-.279-.594-.611-.587zm-2.132-1.095c-.3" \
              "32.007-.595.281-.588.612.006.332.279.594.611.588.332-.00" \
              "7.594-.28.588-.612-.007-.331-.279-.594-.611-.588zm-9.902" \
              " 2.183c.332.007.594.281.588.612-.007.332-.279.595-.611.5" \
              "88-.332-.006-.595-.28-.588-.612.005-.331.279-.594.611-.5" \
              "88zm1.487-.5c-.006.332.256.605.588.612s.605-.257.611-.58" \
              "8c.007-.332-.256-.605-.588-.611-.332-.008-.604.255-.611." \
              "587zm2.132-1.094c-.006.332.256.605.588.612.332.006.605-." \
              "256.611-.588.007-.332-.256-.605-.588-.612-.332-.007-.604" \
              ".256-.611.588zm3.447-5.749c-.331 0-.6.269-.6.6s.269.6.6." \
              "6.6-.269.6-.6-.269-.6-.6-.6zm0-2.225c-.331 0-.6.269-.6.6" \
              "s.269.6.6.6.6-.269.6-.6-.269-.6-.6-.6zm0-2.031c-.331 0-." \
              "6.269-.6.6s.269.6.6.6.6-.269.6-.6-.269-.6-.6-.6z"
            }/>

        </svg>

      Documentation.Type::Store =>
        <svg::icon
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          height="24"
          width="24">

          <path
            d={
              "M22 18.055v2.458c0 1.925-4.655 3.487-10 3.487-5.344 0-10" \
              "-1.562-10-3.487v-2.458c2.418 1.738 7.005 2.256 10 2.256 " \
              "3.006 0 7.588-.523 10-2.256zm-10-3.409c-3.006 0-7.588-.5" \
              "23-10-2.256v2.434c0 1.926 4.656 3.487 10 3.487 5.345 0 1" \
              "0-1.562 10-3.487v-2.434c-2.418 1.738-7.005 2.256-10 2.25" \
              "6zm0-14.646c-5.344 0-10 1.562-10 3.488s4.656 3.487 10 3." \
              "487c5.345 0 10-1.562 10-3.487 0-1.926-4.655-3.488-10-3.4" \
              "88zm0 8.975c-3.006 0-7.588-.523-10-2.256v2.44c0 1.926 4." \
              "656 3.487 10 3.487 5.345 0 10-1.562 10-3.487v-2.44c-2.41" \
              "8 1.738-7.005 2.256-10 2.256z"
            }/>

        </svg>
    }
  }

  get title : String {
    case (of) {
      Documentation.Type::Component => "Components"
      Documentation.Type::Module => "Modules"
      Documentation.Type::Store => "Stores"
    }
  }

  fun render : Html {
    <a::base href={"/" + nameOf(of)}>
      <{ icon }>

      <span::span>
        <{ title }>
      </span>
    </a>
  }
}
