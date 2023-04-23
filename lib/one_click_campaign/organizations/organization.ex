defmodule OneClickCampaign.Organizations.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :description, :string
    field :name, :string
    field :campaign_id, :id
    has_many :npcs, OneClickCampaign.NPCs.NPC

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :description, :campaign_id])
    |> validate_required([:name, :description, :campaign_id])
    |> foreign_key_constraint(:campaign_id)
  end
end
