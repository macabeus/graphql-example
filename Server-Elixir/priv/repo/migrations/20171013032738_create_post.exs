defmodule Myapp.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :body, :text
      add :count_likes, :integer, default: 0
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:user_id])
    create constraint(:posts, :count_likes_must_be_positive_or_zero, check: "count_likes >= 0")
  end
end
