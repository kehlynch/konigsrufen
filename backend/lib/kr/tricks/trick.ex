defmodule Kr.Trick do
  alias Kr.{Cards, Players, Tricks}
  @type trickpoints() :: integer()
  @type trick() :: list(Cards.playedcard())
  @type status() :: {:not_started | :started | :finished,
    {Cards.playedcard() | nil, Cards.playedcard() | nil}}

  @spec get_last_card(pid()) :: Cards.playedcard() | nil
  def get_last_card(pid) do
    pid
    |> Tricks.get_current_trick()
    |> List.last()
  end

  @spec winning?(pid(), Cards.card()) :: boolean()
  def winning?(pid, card) do
    case get_winning_card(pid) do
      nil -> true
      wcard -> Cards.beats?(wcard, card)
    end
  end

  @spec get_lead_player(pid()) :: Players.player()
  def get_lead_player(pid) do
    last_trick =
      pid
      |> Tricks.get_tricks()
      |> Enum.at(-2)

    case last_trick do
      # the lead of the first trick
      # this will have to look at bidding
      nil -> :p1
      trick ->
        trick
        |> Enum.find(&(&1.winning))
        |> Map.get(:player)
    end
  end

  @spec get_winning_card(pid()) :: Cards.playedcard() | nil
  def get_winning_card(pid) do
    pid
    |> Tricks.get_current_trick()
    |> Enum.find(&(&1.winning))
  end

  @spec get_lead_card(pid()) :: Cards.playedcard() | nil
  def get_lead_card(pid) do
    pid
    |> Tricks.get_current_trick()
    |> Enum.at(0)
  end

  @spec not_started?(pid()) :: boolean()
  def not_started?(pid) do
    pid
    |> Tricks.get_current_trick()
    |> Enum.empty?()
  end

  @spec get_status(pid()) :: status()
  def get_status(pid) do
    case {get_lead_card(pid), get_winning_card(pid)} do
      {lc, wc} when is_nil(lc) or is_nil(wc) -> {:not_started, {lc, wc}}
      {lc, wc} -> {:started, {lc, wc}}
    end
  end


  @doc """
  multiply everything by 3, then we divide it later

  """
  @spec get_winner_points(trick) :: {Players.player(), float()}
  def get_winner_points(trick) do
    points =
      trick
      |> Enum.map(fn 
        # %{points: 0} -> 2
        %{points: points} -> (points * 3) - 1
      end)
      |> Enum.sum()
      |> Kernel./(3)
      # |> trunc()
    

    {get_winner(trick), points}
  end

  @spec get_winner(trick) :: Players.player()
  def get_winner(trick) do
    case Enum.find(trick, &(&1.winning)) do
      nil -> nil
      played_card -> played_card.player
    end
  end
end
