defmodule OneClickCampaign.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :description, :text
      add :parent_location_id, references(:locations, on_delete: :nothing)
      add :campaign_id, references(:campaigns, on_delete: :nothing)

      timestamps()
    end

    create index(:locations, [:parent_location_id])
    create index(:locations, [:campaign_id])
  end
end
