defmodule OneClickCampaign.Repo.Migrations.CreateNpcs do
  use Ecto.Migration

  def change do
    create table(:npcs) do
      add :name, :string
      add :prompt, :text
      add :description, :text
      add :image, :text
      add :seed, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:npcs, [:user_id])
  end
end
