defmodule TrelloTaskerWeb.CardLive do
  use TrelloTaskerWeb, :live_view

  alias Phoenix.View
  alias TrelloTasker.Cards
  alias TrelloTasker.Cards.Card
  alias TrelloTaskerWeb.CardView
  alias TrelloTasker.Shared.Services.Trello

  @impl true
  def mount(_params, _session, socket) do
    changeset = Card.changeset(%Card{}, %{})
    # card = Trello.get_card("7ffdJ8bz")
    cards = Cards.list_cards()
    |> Enum.map(&Trello.get_card(&1.path))

    socket = socket |> assign(cards: cards, changeset: changeset)
    {:ok, socket}
  end

  @impl true
  def handle_event("create", %{"card" => card}, socket) do
    # IO.inspect(params)

    changeset = %Ecto.Changeset{Card.changeset(%Card{}, card) | action: :insert}

    changeset.valid?
    |> case do
      false ->
        response({:error, changeset}, socket)

      true ->
        card["path"]
        |> Trello.get_card()
        |> case do
          {:error, msg} ->
            {:noreply, socket |> put_flash(:error, msg) |> push_redirect(to: "/")}

          card_info ->
            card
            |> Cards.create_card()
            |> response(socket)
            {:noreply, card_info}
        end

        {:noreply, socket}
    end
  end

  defp response({:ok, _card}, socket),
    do:
      {:noreply, socket |> put_flash(:info, "Card criado com sucesso!") |> push_redirect(to: "/")}

  defp response({:error, changeset}, socket), do: {:noreply, assign(socket, :changeset, changeset)}

  @impl true
  def render(assings) do
    View.render(CardView, "index.html", assings)
  end
end
