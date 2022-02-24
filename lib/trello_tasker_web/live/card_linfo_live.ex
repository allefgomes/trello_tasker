defmodule TrelloTaskerWeb.CardInfoLive do
  use TrelloTaskerWeb, :live_view

  alias Phoenix.View
  alias TrelloTaskerWeb.CardView
  alias TrelloTasker.Shared.Services.Trello

  @impl true
  def mount(params, _session, socket) do
    card = Trello.get_card(params["id"])
    comments = Trello.get_comments(params["id"])

    socket = socket |> assign(card: card, comments: comments)
    {:ok, socket}
  end

  @impl true
  def render(assings) do
    View.render(CardView, "show.html", assings)
  end
end
