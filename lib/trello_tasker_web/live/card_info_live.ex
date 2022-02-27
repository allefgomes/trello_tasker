defmodule TrelloTaskerWeb.CardInfoLive do
  use TrelloTaskerWeb, :live_view

  alias Phoenix.View
  alias TrelloTasker.Shared.Services.GetCardInfo
  alias TrelloTaskerWeb.CardView

  @impl true
  def mount(params, _session, socket) do
    {:ok, card, comments} = GetCardInfo.execute(params["id"])

    socket = socket |> assign(card: card, comments: comments)
    {:ok, socket}
  end

  @impl true
  def render(assings) do
    View.render(CardView, "show.html", assings)
  end
end
