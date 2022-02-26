defmodule TrelloTasker.Shared.Providers.CacheProvider.CardCacheClient do
  def save(key, value), do: GenServer.cast(:cards_cache, {:put, key, value})
  def recovery(key), do: GenServer.call(:cards_cache, {:get, key})
end
