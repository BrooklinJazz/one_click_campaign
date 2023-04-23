defmodule OneClickCampaign.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :description, :text
      add :campaign_id, references(:campaigns, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:organizations, [:campaign_id])
  end
end
