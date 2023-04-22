defmodule OneClickCampaign.CampaignsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneClickCampaign.Campaigns` context.
  """

  @doc """
  Generate a campaign.
  """
  def campaign_fixture(attrs \\ %{}) do
    {:ok, campaign} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        public: true,
        setting: "some setting"
      })
      |> OneClickCampaign.Campaigns.create_campaign()

    campaign
  end
end
