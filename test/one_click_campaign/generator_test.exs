defmodule OneClickCampaign.GeneratorTest do
  use OneClickCampaign.DataCase
  doctest OneClickCampaign.Generator

  alias OneClickCampaign.Generator
  alias OneClickCampaign.Campaigns
  alias OneClickCampaign.NPCs
  alias OneClickCampaign.Locations
  alias OneClickCampaign.Organizations

  import OneClickCampaign.AccountsFixtures

  test "one_click_campaign/0" do
    # this one click campaign could eventually take inputs and gradually create data with edits that might change how content is generated, but this is a good start.
    user = user_fixture()
    Generator.one_click_campaign(user.id)

    assert [campaign] = Campaigns.list_campaigns(user.id)

    assert [world, continent, city | _] = Locations.list_locations(campaign.id)
    assert [government, good, neutral, evil] = Organizations.list_organizations(campaign.id)
    assert [government_center, general_goods, blacksmith] = Repo.preload(city, :locations).locations

    # generate 3 npcs for each organization
    assert [_, _, _] = Repo.preload(government, :npcs).npcs
    assert [_, _, _] = Repo.preload(good, :npcs).npcs
    assert [_, _, _] = Repo.preload(neutral, :npcs).npcs
    assert [_, _, _] = Repo.preload(evil, :npcs).npcs
  end
end
