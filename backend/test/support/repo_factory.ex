defmodule Kr.Repo.Factory do
  use ExMachina.Ecto, repo: Kr.Repo

  def user_factory do
    %Kr.User{
      email_address: sequence(:email_address, &"email-#{&1}@example.com")
    }
  end

  def store_factory do
    %Kr.Store{
      data: %{}
    }
  end
end
