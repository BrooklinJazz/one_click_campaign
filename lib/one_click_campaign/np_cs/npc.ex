defmodule OneClickCampaign.NPCs.NPC do
  use Ecto.Schema
  import Ecto.Changeset

  schema "npcs" do
    field :name, :string
    field :description, :string
    field :image, :string
    field :seed, :integer
    field :prompt, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(npc, attrs) do
    npc
    |> cast(attrs, [:name, :prompt, :description, :image, :seed])
    |> validate_required([:name, :prompt, :description, :image, :seed])
  end
end
