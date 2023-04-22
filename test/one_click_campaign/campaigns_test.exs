defmodule OneClickCampaign.CampaignsTest do
  use OneClickCampaign.DataCase

  alias OneClickCampaign.Campaigns

  describe "campaigns" do
    alias OneClickCampaign.Campaigns.Campaign

    import OneClickCampaign.CampaignsFixtures

    @invalid_attrs %{description: nil, name: nil, public: nil, setting: nil}

    test "list_campaigns/0 returns all campaigns" do
      campaign = campaign_fixture()
      assert Campaigns.list_campaigns() == [campaign]
    end

    test "get_campaign!/1 returns the campaign with given id" do
      campaign = campaign_fixture()
      assert Campaigns.get_campaign!(campaign.id) == campaign
    end

    test "create_campaign/1 with valid data creates a campaign" do
      valid_attrs = %{
        description: "some description",
        name: "some name",
        public: true,
        setting: "some setting"
      }

      assert {:ok, %Campaign{} = campaign} = Campaigns.create_campaign(valid_attrs)
      assert campaign.description == "some description"
      assert campaign.name == "some name"
      assert campaign.public == true
      assert campaign.setting == "some setting"
    end

    test "create_campaign/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Campaigns.create_campaign(@invalid_attrs)
    end

    test "update_campaign/2 with valid data updates the campaign" do
      campaign = campaign_fixture()

      update_attrs = %{
        description: "some updated description",
        name: "some updated name",
        public: false,
        setting: "some updated setting"
      }

      assert {:ok, %Campaign{} = campaign} = Campaigns.update_campaign(campaign, update_attrs)
      assert campaign.description == "some updated description"
      assert campaign.name == "some updated name"
      assert campaign.public == false
      assert campaign.setting == "some updated setting"
    end

    test "update_campaign/2 with invalid data returns error changeset" do
      campaign = campaign_fixture()
      assert {:error, %Ecto.Changeset{}} = Campaigns.update_campaign(campaign, @invalid_attrs)
      assert campaign == Campaigns.get_campaign!(campaign.id)
    end

    test "delete_campaign/1 deletes the campaign" do
      campaign = campaign_fixture()
      assert {:ok, %Campaign{}} = Campaigns.delete_campaign(campaign)
      assert_raise Ecto.NoResultsError, fn -> Campaigns.get_campaign!(campaign.id) end
    end

    test "change_campaign/1 returns a campaign changeset" do
      campaign = campaign_fixture()
      assert %Ecto.Changeset{} = Campaigns.change_campaign(campaign)
    end
  end
end
