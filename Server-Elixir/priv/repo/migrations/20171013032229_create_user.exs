defmodule Myapp.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :username, :string
      add :password_hash, :string

      timestamps()
    end
  end
end
