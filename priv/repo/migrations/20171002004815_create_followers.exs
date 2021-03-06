defmodule Microblog.Repo.Migrations.CreateFollowers do
  use Ecto.Migration

  def change do
    create table(:followers) do
      add :follower_email, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:followers, [:user_id])
  end
end
