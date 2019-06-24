defmodule Kr.Games do
  alias Kr.{
    Cards,
    Decks,
    Hands,
    NPC,
    Players,
    Scores,
    Settings,
    Tricks
  }

  @type points() :: %{required(Players.player()) => integer()}

  @type game() :: %{
    optional(:finished) => boolean,
    required(:hands) => Hands.hands(),
    required(:talon) => Cards.cardlist(),
    required(:tricks) => Tricks.tricks(),
    optional(:played) => Players.playerlist(),
    optional(:scores) => Scores.scores(),
    optional(:points) => points()
  }

  @human_player :p1

  @spec init_game!(pid()) :: :ok
  def init_game!(pid) do
    game = 
      Decks.deal()
      |> Map.put(:tricks, Tricks.get_tricks(pid))
    Settings.update_setting!(pid, :game, game)
    Hands.add_legal!(pid)
  end

  @spec get_game(pid()) :: game()
  def get_game(pid) do
    Hands.add_legal!(pid)
    Settings.get_setting(pid, :game) |> IO.inspect
  end

  @spec set_finished!(pid()) :: :ok
  def set_finished!(pid) do
    Settings.set_setting!(pid, [:game, :finished], true)
  end

  @spec finished?(pid()) :: :ok
  def finished?(pid) do
    Settings.get_setting(pid, [:game, :finished], false)
  end

  @spec set_points!(pid(), points()) :: :ok
  def set_points!(pid, points) do
    Settings.set_setting!(pid, [:game, :points], points)
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
    IO.puts("advance-game")
    if !finished?(pid) |> IO.inspect do
      case Players.get_next_player(pid) do
        # time to ask the human
        @human_player ->
          Hands.add_legal!(pid, @human_player)
          :ok
        player ->
          card = NPC.get_card(pid, player)
          apply_card_played!(pid, player, card)
      end
    end
  end
end
