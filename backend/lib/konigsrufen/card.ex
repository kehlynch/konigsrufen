defmodule Konigsrufen.Card do
  alias Konigsrufen.Card
  alias Konigsrufen.Suit
  defstruct suit: %Suit{}, value: 0, points: 0, name: ""

  def get_card(suit, value) do
    %Card{
      suit: suit,
      value: value,
      points: get_points(suit, value),
      name: get_name(suit, value),
    }
  end

  def get_points(%Suit{is_trump: true}, value) do
    if Enum.member?([1, 21, 22], value) do
      5
    else
      nil
    end
  end
  def get_points(%Suit{}, value) do
    case value do
      8 -> 5
      7 -> 4
      6 -> 3
      5 -> 2
      _ -> nil
    end
  end

  def get_name(%Suit{is_trump: true}, value) do
    case value do
      22 -> "Sküs"
      21 -> "Mond"
      1 -> "Pagat"
      2 -> "Uhu"
      3 -> "Kakadu"
      _ -> RomanNumerals.convert(value)
    end
  end
  def get_name(suit = %Suit{name: name}, value) do
    case value do
      8 -> "King of #{name}s"
      7 -> "Queen of #{name}s"
      6 -> "Knight of #{name}s"
      5 -> "Jack of #{name}s"
      _ -> "#{pip_name(suit, value)} of #{name}s"
    end
  end
  
  def pip_name(%Suit{pip_reverse: true}, value) do
    case value do
      4 -> 1
      3 -> 2
      2 -> 3
      1 -> 4
    end
  end
  def pip_name(%Suit{}, value) do
    case value do
      4 -> 10
      3 -> 9
      2 -> 8
      1 -> 7
    end
  end
end
