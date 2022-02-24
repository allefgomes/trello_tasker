defmodule TrelloTasker.Shared.Services.Trello do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.trello.com/1/cards"
  plug Tesla.Middleware.Headers, [{"User-Agent", "request"}]
  plug Tesla.Middleware.JSON

  @token Application.get_env(:trello_tasker, :trello)[:token]
  @key Application.get_env(:trello_tasker, :trello)[:key]

  def get_card(card_id) do
    {:ok, response} =
      "#{card_id}?list=true&key=#{@key}&token=#{@token}"
      |> get()

    handle_response(response)
  end

  def get_comments(card_id) do
    {:ok, response} =
      "#{card_id}/actions?commentCard&key=#{@key}&token=#{@token}"
      |> get()

    response.body
    |> Enum.map(&%{content: &1["data"]["text"], username: &1["memberCreator"]["username"]})
  end

  defp handle_response(response) when response.status == 200 do
    body = response.body

    %{
      name: body["name"],
      description: body["desc"],
      image: body["cover"]["sharedSourceUrl"],
      card_id: body["shortLink"],
      completed: body["dueComplete"],
      deliver_date: body["due"] |> handle_delivery_date()
    }
  end

  defp handle_response(response) when response.status != 200 do
    {:error, "Erro ao buscar card"}
  end

  defp handle_delivery_date(nil), do: nil

  defp handle_delivery_date(delivery_date) do
    delivery_date
    |> DateTime.from_iso8601()
    |> handle_date()
  end

  defp handle_date({:error, _error}), do: nil
  defp handle_date({:ok, date, _b}), do: date |> DateTime.to_date()
end
