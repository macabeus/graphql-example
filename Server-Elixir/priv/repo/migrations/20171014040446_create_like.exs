defmodule Myapp.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :post_id, references(:posts, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:likes, [:post_id])
    create index(:likes, [:user_id])
    create unique_index(:likes, [:post_id, :user_id])
  end
end
