defmodule TrelloTaskerWeb.CardLive do
  use TrelloTaskerWeb, :live_view

  alias Phoenix.View
  alias TrelloTasker.Cards.Card
  alias TrelloTasker.Shared.Services.{CreateCard, GetAllCards}
  alias TrelloTaskerWeb.CardView

  @impl true
  def mount(_params, _session, socket) do
    changeset = Card.changeset(%Card{}, %{})
    cards = GetAllCards.execute()

    {:ok, socket |> assign(cards: cards, changeset: changeset)}
  end

  @impl true
  def handle_event("create", %{"card" => card}, socket) do
    changeset = %Ecto.Changeset{Card.changeset(%Card{}, card) | action: :insert}

    changeset.valid?
    |> case do
      false ->
        response({:error, changeset}, socket)

      true ->
        card
        |> CreateCard.execute()
        |> response(socket)
    end
  end

  defp response({:ok, _card}, socket),
    do:
      {:noreply, socket |> put_flash(:info, "Card criado com sucesso!") |> push_redirect(to: "/")}

  defp response({:error, changeset}, socket),
    do: {:noreply, assign(socket, :changeset, changeset)}

  @impl true
  def render(assings) do
    View.render(CardView, "index.html", assings)
  end
end
