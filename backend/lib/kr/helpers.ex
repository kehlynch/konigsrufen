defmodule Kr.Helpers do
  def have_same_ids?(list1, list2) when is_list(list1) and is_list(list2) do
    get_sorted_ids(list1) == get_sorted_ids(list2)
  end

  defp get_sorted_ids(list) when is_list(list) do
    list
    |> Enum.map(&get_id(&1))
    |> Enum.sort()
  end

  defp get_id(%{} = struct) do
    Map.get(struct, :id) || Map.get(struct, "id")
  end

  def atomise(string) when is_binary(string) do
    String.to_atom(string)
  end

  def atomise(list) when is_list(list) do
    Enum.map(list, &atomise(&1))
  end

  def atomise(%_{} = struct) do
    struct
    |> Map.from_struct()
  end

  def atomise(map) when is_map(map) do
    for {key, val} <- map, into: %{} do
      {atomise(key), atomise(val)}
    end
  end

  def atomise(unhandled), do: unhandled

  def human_join(list) when is_list(list) do
    {last, rest} = List.pop_at(list, -1)
    "#{Enum.join(rest, ", ")} and #{last}"
  end
end
