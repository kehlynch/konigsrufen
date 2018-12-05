defmodule Kr.Stores do
  import Ecto.Query, warn: false
  import Kr.Helpers

  alias Kr.Repo
  alias Kr.Store

  def get_user_stores(user_id) do
    Store
    |> where([s], s.user_id == ^user_id)
    |> Repo.all()
  end

  def get_store!(store_id) do
    Store
    |> Repo.get!(store_id)
  end

  def create_store!(attrs) do
    %Store{}
    |> Store.changeset(attrs)
    |> Repo.insert!()
  end

  def update_store!(%Store{} = store, attrs) do
    store
    |> Store.changeset(attrs)
    |> Repo.update!()
  end

  def get_settings(%Store{} = store) do
    store
    |> Map.get(:data)
    |> atomise()
  end
end
