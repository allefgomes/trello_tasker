defmodule TrelloTaskerWeb.CardLiveTest do
  use TrelloTaskerWeb.ConnCase
  import Phoenix.LiveViewTest

  @card_id "7ffdJ8bz"

  test "load page", %{ conn: conn } do
    {:ok, view, html} = live(conn, Routes.card_path(conn, :index))

    assert html =~ "<h1>Monitore seus Cards do Tello</h1>"
    assert render(view) =~ "Monitore seus Cards do Tello"
  end

  # test "handle_event 'create'", %{ conn: conn } do
  #   {:ok, view, html} = live(conn, "/")

  #   assert view
  #     |> element("#create-card")
  #     |> render_submit(%{card: @card_id}) =~ "123 exceeds limits"
  # end
end
