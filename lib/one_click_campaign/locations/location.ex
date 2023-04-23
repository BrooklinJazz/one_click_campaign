defmodule OneClickCampaign.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :description, :string
    field :name, :string
    field :campaign_id, :id

    belongs_to(:parent_location, __MODULE__)
    has_many(:locations, __MODULE__, foreign_key: :parent_location_id)

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :description, :campaign_id, :parent_location_id])
    |> validate_required([:name, :description, :campaign_id])
    |> foreign_key_constraint(:campaign_id)
    |> foreign_key_constraint(:parent_location_id)
  end
end
