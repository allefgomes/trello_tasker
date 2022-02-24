defmodule TrelloTasker.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TrelloTasker.Cards` context.
  """

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        path: "some path"
      })
      |> TrelloTasker.Cards.create_card()

    card
  end
end
