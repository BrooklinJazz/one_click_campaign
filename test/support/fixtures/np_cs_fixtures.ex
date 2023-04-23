defmodule OneClickCampaign.NPCsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `OneClickCampaign.NPCs` context.
  """

  @doc """
  Generate a npc.
  """
  def npc_fixture(attrs \\ %{}) do
    {:ok, npc} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> OneClickCampaign.NPCs.create_npc()

    npc
  end
end
