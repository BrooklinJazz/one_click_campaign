defmodule OneClickCampaign.Generator do
  alias Ecto.Multi
  alias OneClickCampaign.AI
  alias OneClickCampaign.Campaigns
  alias OneClickCampaign.Locations
  alias OneClickCampaign.NPCs
  alias OneClickCampaign.Organizations
  alias OneClickCampaign.Repo

  def one_click_campaign(user_id) do

    # Replace with AI data
    campaign_name = "Campaign Name"
    campaign_description = "Campaign Description"

    world_name = "World Name"
    world_description = "World Description"
    continent_name = "Continent Name"
    continent_description = "Continent Description"
    city_name = "City Name"
    city_description = "City Description"

    government_name = "Government Name"
    government_description = "Government Description"
    evil_organization_name = "Evil Organization Name"
    evil_organization_description = "Evil Organization Description"
    good_organization_name = "Good Organization Description"
    good_organization_description = "Good Organization Description"
    neutral_organization_name = "Neutral Organization Description"
    neutral_organization_description = "Neutral Organization Description"

    government_center_name = "Government Center Name"
    government_center_description = "Government Center Description"
    general_goods_name = "General Goods Name"
    general_goods_description = "General Goods Description"
    blacksmith_name = "Blacksmith Name"
    blacksmith_description = "Blacksmith Description"

    government_npc_1_name = "Government NPC 1 Name"
    government_npc_1_description = "Government NPC 1 Description"
    government_npc_2_name = "Government NPC 2 Name"
    government_npc_2_description = "Government NPC 2 Description"
    government_npc_3_name = "Government NPC 3 Name"
    government_npc_3_description = "Government NPC 3 Description"

    good_npc_1_name = "Good NPC 1 Name"
    good_npc_1_description = "Good NPC 1 Description"
    good_npc_2_name = "Good NPC 2 Name"
    good_npc_2_description = "Good NPC 2 Description"
    good_npc_3_name = "Good NPC 3 Name"
    good_npc_3_description = "Good NPC 3 Description"

    neutral_npc_1_name = "Neutral NPC 1 Name"
    neutral_npc_1_description = "Neutral NPC 1 Description"
    neutral_npc_2_name = "Neutral NPC 2 Name"
    neutral_npc_2_description = "Neutral NPC 2 Description"
    neutral_npc_3_name = "Neutral NPC 3 Name"
    neutral_npc_3_description = "Neutral NPC 3 Description"

    evil_npc_1_name = "Evil NPC 1 Name"
    evil_npc_1_description = "Evil NPC 1 Description"
    evil_npc_2_name = "Evil NPC 2 Name"
    evil_npc_2_description = "Evil NPC 2 Description"
    evil_npc_3_name = "Evil NPC 3 Name"
    evil_npc_3_description = "Evil NPC 3 Description"


    Multi.new()
    |> Multi.insert(
      :campaign,
      Campaigns.change_campaign(%Campaigns.Campaign{}, %{
        name: campaign_name,
        setting: "Fantasy",
        description: campaign_description,
        user_id: user_id
      })
    )
    |> Multi.insert(:world, fn %{campaign: campaign} ->
      Locations.change_location(%Locations.Location{}, %{
        name: world_name,
        description: world_description,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:continent, fn %{campaign: campaign} ->
      Locations.change_location(%Locations.Location{}, %{
        name: continent_name,
        description: continent_description,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:city, fn %{campaign: campaign} ->
      Locations.change_location(%Locations.Location{}, %{
        name: city_name,
        description: city_description,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:government, fn %{campaign: campaign} ->
      Organizations.change_organization(%Organizations.Organization{}, %{
        name: government_name,
        description: government_description,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:evil_organization, fn %{campaign: campaign} ->
      Organizations.change_organization(%Organizations.Organization{}, %{
        name: evil_organization_name,
        description: evil_organization_description,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:good_organization, fn %{campaign: campaign} ->
      Organizations.change_organization(%Organizations.Organization{}, %{
        name: good_organization_name,
        description: good_organization_name,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:neutral_organization, fn %{campaign: campaign} ->
      Organizations.change_organization(%Organizations.Organization{}, %{
        name: neutral_organization_name,
        description: neutral_organization_description,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:government_center, fn %{campaign: campaign, city: city} ->
      Locations.change_location(%Locations.Location{}, %{
        name: government_center_name,
        description: government_center_description,
        parent_location_id: city.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:general_goods, fn %{campaign: campaign, city: city} ->
      Locations.change_location(%Locations.Location{}, %{
        name: general_goods_name,
        description: general_goods_description,
        parent_location_id: city.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:blacksmith, fn %{campaign: campaign, city: city} ->
      Locations.change_location(%Locations.Location{}, %{
        name: blacksmith_name,
        description: blacksmith_description,
        parent_location_id: city.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:government_npc_1, fn %{campaign: campaign, government: government} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: government_npc_1_name,
        description: government_npc_1_description,
        organization_id: government.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:government_npc_2, fn %{campaign: campaign, government: government} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: government_npc_2_name,
        description: government_npc_2_description,
        organization_id: government.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:government_npc_3, fn %{campaign: campaign, government: government} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: government_npc_3_name,
        description: government_npc_3_description,
        organization_id: government.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:good_npc_1, fn %{campaign: campaign, good_organization: good_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: good_npc_1_name,
        description: good_npc_1_description,
        organization_id: good_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:good_npc_2, fn %{campaign: campaign, good_organization: good_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: good_npc_2_name,
        description: good_npc_2_description,
        organization_id: good_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:good_npc_3, fn %{campaign: campaign, good_organization: good_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: good_npc_3_name,
        description: good_npc_3_description,
        organization_id: good_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:neutral_npc_1, fn %{campaign: campaign, neutral_organization: neutral_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: neutral_npc_1_name,
        description: neutral_npc_1_description,
        organization_id: neutral_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:neutral_npc_2, fn %{campaign: campaign, neutral_organization: neutral_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: neutral_npc_2_name,
        description: neutral_npc_2_description,
        organization_id: neutral_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:neutral_npc_3, fn %{campaign: campaign, neutral_organization: neutral_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: neutral_npc_3_name,
        description: neutral_npc_3_description,
        organization_id: neutral_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:evil_npc_1, fn %{campaign: campaign, evil_organization: evil_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: evil_npc_1_name,
        description: evil_npc_1_description,
        organization_id: evil_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:evil_npc_2, fn %{campaign: campaign, evil_organization: evil_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: evil_npc_2_name,
        description: evil_npc_2_description,
        organization_id: evil_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Multi.insert(:evil_npc_3, fn %{campaign: campaign, evil_organization: evil_organization} ->
      NPCs.change_npc(%NPCs.NPC{}, %{
        name: evil_npc_3_name,
        description: evil_npc_3_description,
        organization_id: evil_organization.id,
        campaign_id: campaign.id
      })
    end)
    |> Repo.transaction()

    # world

    # continent

    # world_name = AI.prompt("Generate a unique fantasy world name for the Dungeons and Dragons world.")
    # description = AI.prompt("Describe the world of #{world_name}")
    # Locations.create_location(%{name: world, setting: "Fantasy", description: description, user_id: user_id})
  end
end
