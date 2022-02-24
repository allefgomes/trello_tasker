defmodule TrelloTaskerWeb.CardInfoLiveTest do
  use TrelloTaskerWeb.ConnCase
  import Phoenix.LiveViewTest

  alias TrelloTasker.Shared.Services.Trello

  @card_id "7ffdJ8bz"

  test "load page", %{conn: conn} do
    card = Trello.get_card(@card_id)
    {:ok, _view, html} = live(conn, Routes.card_info_path(conn, :show, @card_id))

    assert html =~ card.name
  end
end
