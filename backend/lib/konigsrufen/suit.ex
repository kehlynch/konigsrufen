defmodule Konigsrufen.Suit do
  alias Konigsrufen.Suit

  defstruct name: "", is_trump: false, pip_reverse: false

  def init(opts \\ []) do
    %Suit{
      name: opts[:name],
      is_trump: opts[:is_trump] || false,
      pip_reverse: opts[:pip_reverse] || false,
    }
  end
end
