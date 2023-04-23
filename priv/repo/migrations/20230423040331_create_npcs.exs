defmodule OneClickCampaign.Repo.Migrations.CreateNpcs do
  use Ecto.Migration

  def change do
    create table(:npcs) do
      add :name, :string
      add :description, :text
      add :campaign_id, references(:campaigns, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:npcs, [:campaign_id])
  end
end
