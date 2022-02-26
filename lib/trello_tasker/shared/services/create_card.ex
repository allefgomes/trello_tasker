defmodule TrelloTasker.Shared.Services.CreateCard do
  alias TrelloTasker.Cards
  alias TrelloTasker.Shared.Providers.CacheProvider.CardCacheClient
  alias TrelloTasker.Shared.Services.Trello

  @table "cards-table"

  def execute(card) do
    card["path"]
    |> Trello.get_card()
    |> case do
      {:error, message} ->
        {:trello_error, message}

      _card_info ->
        card
        |> Cards.create_card()
        |> return_call()
    end
  end

  def return_call({:error, changeset}), do: {:error, changeset}

  def return_call({:ok, card}) do
    {:ok, cards} = CardCacheClient.recovery(@table)

    card_trello = card.path |> Trello.get_card()

    CardCacheClient.save(@table, [card_trello] ++ cards)
    {:ok, card}
  end
end
