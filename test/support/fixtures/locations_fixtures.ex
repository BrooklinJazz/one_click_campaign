defmodule OneClickCampaign.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneClickCampaign.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> OneClickCampaign.Locations.create_location()

    location
  end
end
