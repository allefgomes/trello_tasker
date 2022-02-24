defmodule TrelloTasker.Shared.Services.TrelloTest do
  use TrelloTasker.DataCase

  @card_id_with_date "7ffdJ8bz"
  @card_id_without_date "nsSuPPz8"

  describe "trello" do
    alias TrelloTasker.Shared.Services.Trello

    test "get_card/1 returns a card changeset" do
      card = Trello.get_card(@card_id_with_date)

      assert %{
               card_id: "7ffdJ8bz",
               completed: false,
               deliver_date: ~D[2022-03-01],
               description: "Evento A que vai ser um sucesso!",
               image:
                 "https://images.unsplash.com/photo-1645345243302-3504e2f99bb5?ixid=Mnw3MDY2fDB8MXxjb2xsZWN0aW9ufDV8MzE3MDk5fHx8fHwyfHwxNjQ1NjYwNzgy&ixlib=rb-1.2.1&w=2560&h=2048&q=90",
               name: "Evento A"
             } = card
    end

    test "get_card/1 returns a card changeset without date " do
      card = Trello.get_card(@card_id_without_date)

      assert %{
               card_id: "nsSuPPz8",
               completed: false,
               deliver_date: nil,
               description: "VAMOOOOOOOOOOOO",
               image:
                 "https://images.unsplash.com/photo-1645290099397-f73b22c51260?ixid=Mnw3MDY2fDB8MXxjb2xsZWN0aW9ufDR8MzE3MDk5fHx8fHwyfHwxNjQ1NzAzOTg0&ixlib=rb-1.2.1&w=2560&h=2048&q=90",
               name: "Evento B"
             } = card
    end

    test "get_card/1 with invalid card_id returns a error" do
      card = Trello.get_card(nil)

      assert {:error, "Erro ao buscar card"} = card
    end

    test "get_comments/1 returns a card changeset" do
      comments = Trello.get_comments(@card_id_with_date)

      assert [
               %{content: "Comentário 5", username: "allefgomes"},
               %{content: "Comentário 4", username: "allefgomes"},
               %{content: "Comentário 3", username: "allefgomes"},
               %{content: "Comentário 2", username: "allefgomes"},
               %{content: "Comentário 1", username: "allefgomes"}
             ] = comments
    end
  end
end
