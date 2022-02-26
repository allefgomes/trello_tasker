defmodule TrelloTasker.Shared.Services.GetAllCards do
  alias TrelloTasker.Cards
  alias TrelloTasker.Shared.Providers.CacheProvider.CardCacheClient
  alias TrelloTasker.Shared.Services.Trello

  @table "cards-table"

  def execute do
    CardCacheClient.recovery(@table)
    |> case do
      {:not_found, []} ->
        cards =
          Cards.list_cards()
          |> Enum.map(&Trello.get_card(&1.path))

        CardCacheClient.save(@table, cards)
        cards

      {:ok, cards} ->
        cards
    end
  end
end
