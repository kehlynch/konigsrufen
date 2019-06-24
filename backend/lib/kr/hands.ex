defmodule Kr.Hands do
  alias Kr.{Cards, Players, Settings, Trick}

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
  def get_hand(pid, player) do
    Settings.get_setting(pid, [:game, :hands, player])
  end

  @spec get_legal_cards(pid(), Players.player()) :: Cards.cardlist()
  def get_legal_cards(pid, player) do
    hand = get_hand(pid, player)

    hand
    |> Map.values()
    |> List.flatten()
    |> Enum.filter(&is_legal?(pid, &1, hand))
  end

  @spec add_legal!(pid()) :: :ok
  def add_legal!(pid) do
    [:p1, :p2, :p3, :p4]
    |> Enum.each(&add_legal!(pid, &1))
  end


  @spec add_legal!(pid(), Players.player()) :: :ok
  def add_legal!(pid, player) do
    hand = get_hand(pid, player)
    hand_with_legal =
      hand
      |> Enum.map(fn {suit, cardlist} ->
          cardlist_with_legal =
            cardlist
            |> Enum.map(fn card ->
              legal = is_legal?(pid, card, hand)
              Map.put(card, :legal, legal)
            end)
          {suit, cardlist_with_legal}
        end)
        |> Map.new()
    set_hand!(pid, player, hand_with_legal)
  end

  def is_legal?(pid, card, hand) do
    {status, {lcard, wcard}} = Trick.get_status(pid)
    has_one_trump = length(hand.trump) === 1

    is_trump = card.suit === :trump
    is_pagat = card.slug === :trump_1
    
    has_cards_in_led_suit = !is_nil(lcard) and cards_in_suit?(hand, lcard.suit)
    has_trumps = cards_in_suit?(hand, :trump)

    in_lead_suit = !is_nil(lcard) and lcard.suit === card.suit
    has_playups_in_suit = !is_nil(wcard) and cards_in_suit_above?(hand, card, wcard.value)
    is_playup = !is_nil(wcard) and card.value > wcard.value
    trump_winning = !is_nil(wcard) and wcard.suit === :trump
    trump_lead = !is_nil(lcard) and lcard.suit === :trump
    cond do
      # never legal in Trishaken
      is_pagat and not has_one_trump -> false
      # lead
      status == :not_started -> true
      # have an in suit card
      has_cards_in_led_suit ->
        cond do
          !in_lead_suit -> false
          !trump_lead && trump_winning -> true
          is_playup -> true
          !has_playups_in_suit -> true
          true -> false
        end
      # have trumps
      has_trumps ->
        cond do
          !is_trump -> false
          trump_winning -> is_playup || !has_playups_in_suit
          true -> true
        end
      # have no in suit cards, and no trumps - play anything
      true -> true
    end
  end

  defp cards_in_suit?(hand, suit) do
    hand
    |> Map.get(suit, [])
    |> Enum.empty?()
    |> Kernel.not()
  end

  defp cards_in_suit_above?(hand, %{suit: suit}, winning_value) do
    hand
    |> Map.get(suit)
    |> Enum.filter(&(&1.value > winning_value))
    |> Enum.empty?()
    |> Kernel.not()
  end

end
