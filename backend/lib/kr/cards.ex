defmodule Kr.Cards do
  @type slug() :: atom()
  @type suit() :: atom()
  @type value() :: integer()
  @type points() :: integer()

  @type card() :: %{
    required(:slug) => slug(),
    required(:suit) => suit(),
    required(:value) => value(),
    required(:points) => points()
  }

  @type cardlist() :: list(card())

  @trump_points %{
    1 => 5,
    21 => 5,
    22 => 5
  }

  @nontrump_points %{
    8 => 5,
    7 => 4,
    6 => 3,
    5 => 2,
  }

  @spec get_card(suit(), value()) :: card()
  def get_card(suit, value) do
    Map.new()
    |> Map.put(:slug, get_slug(suit, value))
    |> Map.put(:suit, suit)
    |> Map.put(:value, value)
    |> Map.put(:points, get_points(suit, value))
  end

  @spec get_card(slug() | nil) :: card() | nil
  def get_card(nil), do: nil

  def get_card(slug) do
    suit = get_suit(slug)
    value = get_value(slug)
    
    Map.new()
    |> Map.put(:slug, slug)
    |> Map.put(:suit, suit)
    |> Map.put(:value, value)
    |> Map.put(:points, get_points(suit, value))
  end

  @spec get_points(suit(), value()) :: points()
  def get_points(:trump, value) do
    @trump_points
    |> Map.get(value, 0)
  end

  def get_points(_suit, value) do
    @nontrump_points
    |> Map.get(value, 0)
  end

  @spec get_slug(suit(), value()) :: slug()
  def get_slug(suit, value) do
    Atom.to_string(suit)
    |> Kernel.<>("_")
    |> Kernel.<>(Integer.to_string(value))
    |> String.to_atom()
  end

  @spec get_suit(slug()) :: suit()
  def get_suit(slug) do
    slug
    |> Atom.to_string()
    |> String.split("_")
    |> Enum.at(0)
    |> String.to_atom()
  end

  @spec get_value(slug()) :: value()
  def get_value(slug) do
    slug
    |> Atom.to_string()
    |> String.split("_")
    |> Enum.at(1)
    |> String.to_integer()
  end
end
