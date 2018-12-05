defmodule Kr.Games do
  alias Kr.{
    Cards,
    Decks,
    Hands,
    NPC,
    Players,
    Settings,
    Tricks
  }

  @type game() :: %{
    required(:hands) => Hands.hands(),
    required(:talon) => Cards.cardlist(),
    optional(:current_trick) => Tricks.trick(),
    optional(:tricks) => Tricks.tricks(),
    optional(:played) => Players.playerlist()
  }

  @human_player :p1

  @spec init_game!(pid()) :: :ok
  def init_game!(pid) do
    Settings.update_setting!(pid, :game, Decks.deal())
  end

  @spec get_game(pid()) :: game()
  def get_game(pid) do
    Settings.get_setting(pid, :game)
  end

  @spec apply_card_played!(pid(), Players.player(), Cards.slug() | Cards.card()) :: no_return()
  def apply_card_played!(pid, player, slug) when is_atom(slug) do
    card = Cards.get_card(slug)
    apply_card_played!(pid, player, card)
  end

  def apply_card_played!(pid, player, card) do
    Hands.remove_card!(pid, player, card)
    Tricks.add_to_current!(pid, player, card)
    Players.set_played!(pid, player)
    # this recurively runs apply_card_played!/3 until it hits a human player
    # or ends the trick
    advance_game!(pid)
  end

  @spec advance_game!(pid()) :: :ok
  def advance_game!(pid) do
    case Players.get_next_player(pid) do
      # time to ask the human
      @human_player -> :ok
      # 4 cards have been played
      nil -> :ok
      player ->
        card = NPC.get_card(pid, player)
        apply_card_played!(pid, player, card)
    end
  end
end
