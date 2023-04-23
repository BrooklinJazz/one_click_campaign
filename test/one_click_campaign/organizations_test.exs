defmodule OneClickCampaign.OrganizationsTest do
  use OneClickCampaign.DataCase

  alias OneClickCampaign.Organizations

  describe "organizations" do
    alias OneClickCampaign.Organizations.Organization

    import OneClickCampaign.OrganizationsFixtures
    import OneClickCampaign.CampaignsFixtures
    import OneClickCampaign.AccountsFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_organizations/0 returns all organizations for a campaign" do
      user = user_fixture()
      campaign1 = campaign_fixture(user_id: user.id)
      campaign2 = campaign_fixture(user_id: user.id)
      organization1 = organization_fixture(campaign_id: campaign1.id)
      organization2 = organization_fixture(campaign_id: campaign2.id)
      assert Organizations.list_organizations(campaign1.id) == [organization1]
      assert Organizations.list_organizations(campaign2.id) == [organization2]
    end

    test "get_organization!/1 returns the organization with given id" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      organization = organization_fixture(campaign_id: campaign.id)
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)

      valid_attrs = %{
        description: "some description",
        name: "some name",
        campaign_id: campaign.id
      }

      assert {:ok, %Organization{} = organization} =
               Organizations.create_organization(valid_attrs)

      assert organization.description == "some description"
      assert organization.name == "some name"
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      organization = organization_fixture(campaign_id: campaign.id)
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Organization{} = organization} =
               Organizations.update_organization(organization, update_attrs)

      assert organization.description == "some updated description"
      assert organization.name == "some updated name"
    end

    test "update_organization/2 with invalid data returns error changeset" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      organization = organization_fixture(campaign_id: campaign.id)

      assert {:error, %Ecto.Changeset{}} =
               Organizations.update_organization(organization, @invalid_attrs)

      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      organization = organization_fixture(campaign_id: campaign.id)
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      organization = organization_fixture(campaign_id: campaign.id)
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
