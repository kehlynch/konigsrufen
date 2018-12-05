defmodule Kr.Store do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Kr.{Store, User}

  schema "stores" do
    field :data, :map, default: %{}

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Store{} = store, attrs \\ %{}) do
    store
    |> cast(attrs, [:user_id, :data])
    |> foreign_key_constraint(:user_id)
  end
end
