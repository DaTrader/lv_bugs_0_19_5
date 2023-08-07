defmodule LvBugs0195Web.PageController do
  use LvBugs0195Web, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end
end
