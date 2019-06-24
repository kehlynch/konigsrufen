defmodule Kr.Scores do
  alias Kr.{Games, Players, Settings, Tricks}
  @type score :: %{
    required(Players.player) => integer()
  }

  @type scores :: [score]

  @spec get_initial_score() :: score()
  def get_initial_score() do
    %{p1: 0, p2: 0, p3: 0, p4: 0}
  end

  @spec get_scores(pid()) :: scores()
  def get_scores(pid) do
    Settings.get_setting(pid, [:game, :scores], [get_initial_score()])
  end

  @spec set_scores!(pid(), scores()) :: :ok
  def set_scores!(pid, scores) do
    Settings.set_setting!(pid, [:game, :scores], scores)
  end

  @spec get_current_score(pid()) :: score()
  def get_current_score(pid) do
    pid
    |> get_scores()
    |> List.last()
  end

  @spec add_score!(pid()) :: :ok
  def add_score!(pid) do
    {points, score} = calculate_score(pid)
    Games.set_points!(pid, points)
    do_add_score!(pid, score)
  end

  @spec do_add_score!(pid(), score()) :: :ok
  def do_add_score!(pid, score) do
    Settings.update_setting!(pid, [:game, :scores], [score])
  end

  @spec calculate_score(pid()) :: score()
  def calculate_score(pid) do
    points = Tricks.get_points(pid)
    # Trischaken only
    {loser, _score} = Enum.max(points)

    score =
      pid
      |> get_current_score()
      |> Enum.map(fn
        {^loser, score} -> {loser, score - 3}
        {player, score} -> {player, score + 1}
      end)
      |> Map.new()

    {points, score}
  end
end
