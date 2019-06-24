defmodule Kr.Tricks do
  alias Kr.{Cards, Games, Players, Scores, Settings, Trick}

  @type tricks() :: list(Trick.trick())
  @type points() :: %{
    required(Players.player()) => integer()
  }

  @spec get_tricks(pid()) :: tricks()
  def get_tricks(pid) do
    Settings.get_setting(pid, [:game, :tricks], [[]])
  end

  @spec set_tricks!(pid(), tricks()) :: :ok
  def set_tricks!(pid, tricks) do
    Settings.set_setting!(pid, [:game, :tricks], tricks)
  end

  @spec add_trick!(pid(), Trick.trick()) :: :ok
  def add_trick!(pid, trick) do
    Settings.update_setting!(pid, [:game, :tricks], [trick])
  end

  @spec get_current_trick(pid()) :: Trick.trick()
  def get_current_trick(pid) do
    pid
    |> get_tricks()
    |> List.last()
  end

  @spec add_to_current!(pid(), Players.player(), Cards.card()) :: nil | :ok
  def add_to_current!(pid, player, card) do
    played_card = 
      card
      |> Map.put(:player, player)
      |> Map.put(:winning, Trick.winning?(pid, card))

    updated =
      pid
      |> get_tricks()
      |> List.update_at(-1, fn trick ->
        case played_card do
          %{winning: true} ->
            updated_trick = 
              trick
              |> Enum.map(&Map.put(&1, :winning, false))
            updated_trick ++ [played_card]
          _ -> trick ++ [played_card]
        end
      end)

    set_tricks!(pid, updated)

    if Enum.at(updated, -1) |> length === 4 do
      if length(updated) === 12 do
        # end the game
        Scores.add_score!(pid)
        Games.set_finished!(pid)
      else
        # end the current trick by adding a new one
        add_trick!(pid, [])
      end
    end
  end

  @spec get_points(pid()) :: points()
  def get_points(pid) do
    pid
    |> get_tricks()
    |> Enum.reduce(%{}, fn trick, acc ->
      {player, points} = Trick.get_winner_points(trick)
      Map.update(acc, player, 0, &(&1 + points))
    end)
    |> Enum.map(fn {player, points} -> {player, trunc(points)} end)
    |> Map.new()
  end
end
