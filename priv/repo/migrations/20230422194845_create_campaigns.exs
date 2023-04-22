defmodule OneClickCampaign.Repo.Migrations.CreateCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :name, :string
      add :setting, :text
      add :description, :text
      add :public, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:campaigns, [:user_id])
  end
end
