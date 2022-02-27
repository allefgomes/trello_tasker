defmodule TrelloTasker.Shared.Services.GetCardInfo do
  # alias TrelloTasker.Cards
  alias TrelloTasker.Shared.Providers.CacheProvider.CardCacheClient
  alias TrelloTasker.Shared.Services.Trello

  @table "cards-table"

  def execute(id) do
    CardCacheClient.recovery(id)
    |> case do
      {:ok, {card, comments}} ->
        {:ok, card, comments}

      {:not_found, []} ->
        {:ok, cards} = CardCacheClient.recovery(@table)
        card_info = cards |> Enum.find(&(&1.card_id == id))

        card_comments = Trello.get_comments(id)
        CardCacheClient.save(id, {card_info, card_comments})

        {:ok, card_info, card_comments}
    end
  end
end
