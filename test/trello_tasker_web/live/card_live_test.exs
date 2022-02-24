defmodule TrelloTaskerWeb.CardLiveTest do
  use TrelloTaskerWeb.ConnCase
  import Phoenix.LiveViewTest

  @card_id "stvxJXK3"

  test "load page", %{ conn: conn } do
    {:ok, view, html} = live(conn, Routes.card_path(conn, :index))

    assert html =~ "<h1>Monitore seus Cards do Tello</h1>"
    assert render(view) =~ "Monitore seus Cards do Tello"
  end

  test "handle_event 'create'", %{ conn: conn } do
    {:ok, view, _html} = live(conn, "/")
    {_, map_response} = view
          |> element("form")
          |> render_submit(%{card: %{ path: @card_id }})

    {_, mapa_to_check_redirect} = map_response

    assert mapa_to_check_redirect[:to] == "/"
  end

  test "handle_event 'create' with invalid card_id", %{ conn: conn } do
    {:ok, view, _html} = live(conn, "/")
    res = view
          |> element("form")
          |> render_submit(%{card: %{ path: "" }})

    assert res =~ "can&#39;t be blank"
  end
end
