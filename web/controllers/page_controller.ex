defmodule Vlitch.PageController do
  use Vlitch.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
