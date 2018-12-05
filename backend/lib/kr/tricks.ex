defmodule Kr.Tricks do
  alias Kr.{Cards, Players, Settings}

  @type trick() :: %{
    required(:cards) => Cards.cardlist(),
    required(:p1) => Cards.card(),
    required(:p2) => Cards.card(),
    required(:p3) => Cards.card(),
    required(:p4) => Cards.card(),
    required(:lead) => Players.player(),
    required(:winner) => Players.player()
  }

  @type tricks() :: list(trick())

  @spec get_tricks(pid()) :: tricks()
  def get_tricks(pid) do
    Settings.get_setting(pid, [:game, :tricks], %{})
  end

  @spec get_current(pid()) :: trick()
  def get_current(pid) do
    Settings.get_setting(pid, [:game, :current_trick])
  end

  @spec add_to_current!(pid(), Players.player(), Cards.card()) :: :ok
  def add_to_current!(pid, player, card) do
    Settings.set_setting!(pid, [:game, :current_trick, player], card)
    Settings.update_setting!(pid, [:game, :current_trick, :tricks], [card])
  end

  @spec get_last_card(pid()) :: Cards.card() | nil
  def get_last_card(pid) do
    pid
    |> get_current()
    |> Map.get(:cards)
    |> do_get_last_card()
  end

  @spec do_get_last_card(Cards.cardlist()) :: Cards.card() | nil
  defp do_get_last_card(nil), do: nil
  defp do_get_last_card(cards), do: List.last(cards)
end
