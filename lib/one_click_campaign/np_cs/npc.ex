defmodule OneClickCampaign.NPCs.NPC do
  use Ecto.Schema
  import Ecto.Changeset

  schema "npcs" do
    field :description, :string
    field :name, :string
    field :campaign_id, :id

    timestamps()
  end

  @doc false
  def changeset(npc, attrs) do
    npc
    |> cast(attrs, [:name, :description, :campaign_id])
    |> validate_required([:name, :description, :campaign_id])
    |> foreign_key_constraint(:campaign_id)
  end
end
