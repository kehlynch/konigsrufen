defmodule Kr.Players do
  alias Kr.{Settings, Trick}

  @type player :: :p1 | :p2 | :p3 | :p4
  @type playerlist :: list(player())

  @spec get_next_player(pid()) :: atom()
  def get_next_player(pid) do
    pid
    |> get_played()
    |> do_get_next_player(pid)
  end

  @spec set_played!(pid(), atom()) :: :ok
  def set_played!(pid, player) do
    case get_played(pid) do
      played when length(played) === 3 ->
        Settings.set_setting!(pid, [:game, :played], [])
      _ -> 
        Settings.update_setting!(pid, [:game, :played], [player])
    end
  end

  @spec get_played(pid()) :: list(atom())
  def get_played(pid) do
    Settings.get_setting(pid, [:game, :played], [])
  end

  @spec do_get_next_player(list(atom), pid()) :: nil | atom()
  defp do_get_next_player(players, pid) when is_list(players) do
    case length(players) do
      n when n in [0, 4] -> Trick.get_lead_player(pid)
      _ ->
        players
        |> List.last()
        |> do_get_next_player()
    end
  end

  @spec do_get_next_player(atom()) :: atom()
  defp do_get_next_player(:p1), do: :p2
  defp do_get_next_player(:p2), do: :p3
  defp do_get_next_player(:p3), do: :p4
  defp do_get_next_player(:p4), do: :p1
end
