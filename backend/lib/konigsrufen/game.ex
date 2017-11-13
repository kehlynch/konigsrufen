defmodule Konigsrufen.Game do

  alias Konigsrufen.{Game, Deck}

  @deck Deck.get_deck()

  defstruct talon: [], hands: []
  
  def get_game do
    %{hands: hands, talon: talon} = deal()
    %Game{
      hands: hands,
      talon: talon,
    }
  end

  def deal do
    {talon, hands} = 
      @deck
      |> Enum.shuffle
      |> Enum.chunk_every(12, 12, [])
      |> List.pop_at(-1)
    %{hands: hands, talon: talon}
  end

end
