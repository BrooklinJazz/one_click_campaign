defmodule OneClickCampaign.LocationsTest do
  use OneClickCampaign.DataCase

  alias OneClickCampaign.Locations

  describe "locations" do
    alias OneClickCampaign.Locations.Location

    import OneClickCampaign.AccountsFixtures
    import OneClickCampaign.CampaignsFixtures
    import OneClickCampaign.LocationsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_locations/0 returns all locations in a campaign" do
      user = user_fixture()
      campaign1 = campaign_fixture(user_id: user.id)
      campaign2 = campaign_fixture(user_id: user.id)
      location1 = location_fixture(campaign_id: campaign1.id)
      location2 = location_fixture(campaign_id: campaign2.id)
      assert Locations.list_locations(campaign1.id) == [location1]
      assert Locations.list_locations(campaign2.id) == [location2]
    end

    test "get_location!/1 returns the location with given id" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      location = location_fixture(campaign_id: campaign.id)
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      valid_attrs = %{description: "some description", name: "some name", campaign_id: campaign.id}

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.description == "some description"
      assert location.name == "some name"
    end

    test "create_location/1 with parent location creates a sub location" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      parent_location = location_fixture(campaign_id: campaign.id)
      valid_attrs = %{description: "some description", name: "some name", campaign_id: campaign.id, parent_location_id: parent_location.id}

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.description == "some description"
      assert location.name == "some name"

      assert Repo.preload(parent_location, :locations).locations == [location]
      assert Repo.preload(location, :parent_location) == parent_location
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      location = location_fixture(campaign_id: campaign.id)
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.description == "some updated description"
      assert location.name == "some updated name"
    end

    test "update_location/2 with invalid data returns error changeset" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      location = location_fixture(campaign_id: campaign.id)
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      location = location_fixture(campaign_id: campaign.id)
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      location = location_fixture(campaign_id: campaign.id)
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end
end
