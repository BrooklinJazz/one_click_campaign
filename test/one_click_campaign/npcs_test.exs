defmodule OneClickCampaign.NPCsTest do
  use OneClickCampaign.DataCase

  alias OneClickCampaign.NPCs

  describe "npcs" do
    alias OneClickCampaign.NPCs.NPC

    import OneClickCampaign.NPCsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_npcs/0 returns all npcs" do
      npc = npc_fixture()
      assert NPCs.list_npcs() == [npc]
    end

    test "get_npc!/1 returns the npc with given id" do
      npc = npc_fixture()
      assert NPCs.get_npc!(npc.id) == npc
    end

    test "create_npc/1 with valid data creates a npc" do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %NPC{} = npc} = NPCs.create_npc(valid_attrs)
      assert npc.description == "some description"
      assert npc.name == "some name"
    end

    test "create_npc/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = NPCs.create_npc(@invalid_attrs)
    end

    test "update_npc/2 with valid data updates the npc" do
      npc = npc_fixture()
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %NPC{} = npc} = NPCs.update_npc(npc, update_attrs)
      assert npc.description == "some updated description"
      assert npc.name == "some updated name"
    end

    test "update_npc/2 with invalid data returns error changeset" do
      npc = npc_fixture()
      assert {:error, %Ecto.Changeset{}} = NPCs.update_npc(npc, @invalid_attrs)
      assert npc == NPCs.get_npc!(npc.id)
    end

    test "delete_npc/1 deletes the npc" do
      npc = npc_fixture()
      assert {:ok, %NPC{}} = NPCs.delete_npc(npc)
      assert_raise Ecto.NoResultsError, fn -> NPCs.get_npc!(npc.id) end
    end

    test "change_npc/1 returns a npc changeset" do
      npc = npc_fixture()
      assert %Ecto.Changeset{} = NPCs.change_npc(npc)
    end
  end
end
