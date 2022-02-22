defmodule TrelloTaskerWeb.PageController do
  use TrelloTaskerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
