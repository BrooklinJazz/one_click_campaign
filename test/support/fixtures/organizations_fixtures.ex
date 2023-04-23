defmodule OneClickCampaign.OrganizationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneClickCampaign.Organizations` context.
  """

  @doc """
  Generate a organization.
  """
  def organization_fixture(attrs \\ %{}) do
    {:ok, organization} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> OneClickCampaign.Organizations.create_organization()

    organization
  end
end
