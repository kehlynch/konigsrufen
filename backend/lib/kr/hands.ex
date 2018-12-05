defmodule Kr.Hands do
  alias Kr.{Cards, Players, Settings}

  @type hand() :: %{
    required(:trump) => Cards.cardlist(),
    required(:club) => Cards.cardlist(),
    required(:diamond) => Cards.cardlist(),
    required(:heart) => Cards.cardlist()
  }

  @type hands() :: %{
    required(:p1) => hand(),
    required(:p2) => hand(),
    required(:p3) => hand(),
    required(:p4) => hand()
  }

  @spec build_hands(Cards.cardlist) :: hands()
  def build_hands(cards) do
    {p1, p2, p3, p4} =
      Enum.map(cards, &build_hand(&1))
      |> List.to_tuple

    %{p1: p1, p2: p2, p3: p3, p4: p4}
  end

  @spec build_hand(Cards.cardlist) :: hand()
  def build_hand(cards) when is_list(cards) do
    cards
    |> Enum.sort(& &1.value > &2.value)
    |> Enum.group_by(& &1.suit)
  end

  @spec remove_card!(pid(), Players.player(), Cards.card()) :: :ok
  def remove_card!(pid, player, card) do
    new_cards =
      pid
      |> get_hand(player)
      |> Enum.map(fn {suit, cardlist} ->
        {suit, do_remove_card!(cardlist, card)}
      end)
      |> Map.new()

    set_hand!(pid, player, new_cards)
  end

  @spec do_remove_card!(Cards.cardlist, Cards.card()) :: Cards.cardlist()
  defp do_remove_card!(cards, card) do
    Enum.filter(cards, &(&1.slug !== card.slug))
  end

  @spec set_hand!(pid(), atom(), hand()) :: :ok
  def set_hand!(pid, player, hand) do
    Settings.set_setting!(pid, [:game, :hands, player], hand)
  end

  @spec get_hands(pid()) :: hands()
  def get_hands(pid) do
    Settings.get_setting(pid, [:game, :hands])
  end

  @spec get_hand(pid(), Players.player()) :: hand()
  def get_hand(pid, player) when is_pid(pid) do
    Settings.get_setting(pid, [:game, :hands, player])
  end
end
