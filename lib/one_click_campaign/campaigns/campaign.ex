defmodule OneClickCampaign.Campaigns.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campaigns" do
    field :description, :string
    field :name, :string
    field :public, :boolean, default: false
    field :setting, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :setting, :description, :public, :user_id])
    |> validate_required([:name, :setting, :description, :public, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
