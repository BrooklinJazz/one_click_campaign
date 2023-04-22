defmodule OneClickCampaignWeb.CampaignLiveTest do
  use OneClickCampaignWeb.ConnCase

  import Phoenix.LiveViewTest
  import OneClickCampaign.CampaignsFixtures
  import OneClickCampaign.AccountsFixtures

  @create_attrs %{
    description: "some description",
    name: "some name",
    public: true,
    setting: "some setting"
  }
  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    public: false,
    setting: "some updated setting"
  }
  @invalid_attrs %{description: nil, name: nil, public: false, setting: nil}

  describe "Index" do
    test "lists all campaigns", %{conn: conn} do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, _index_live, html} = live(conn, ~p"/campaigns")

      assert html =~ "Listing Campaigns"
      assert html =~ campaign.description
    end

    test "saves new campaign", %{conn: conn} do
      conn = log_in_user(conn, user_fixture())
      {:ok, index_live, _html} = live(conn, ~p"/campaigns")

      assert index_live |> element("a", "New Campaign") |> render_click() =~
               "New Campaign"

      assert_patch(index_live, ~p"/campaigns/new")

      assert index_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#campaign-form", campaign: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/campaigns")

      html = render(index_live)
      assert html =~ "Campaign created successfully"
      assert html =~ "some description"
    end

    test "updates campaign in listing", %{conn: conn} do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/campaigns")

      assert index_live |> element("#campaigns-#{campaign.id} a", "Edit") |> render_click() =~
               "Edit Campaign"

      assert_patch(index_live, ~p"/campaigns/#{campaign}/edit")

      assert index_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#campaign-form", campaign: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/campaigns")

      html = render(index_live)
      assert html =~ "Campaign updated successfully"
      assert html =~ "some updated description"
    end

    test "deletes campaign in listing", %{conn: conn} do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, index_live, _html} = live(conn, ~p"/campaigns")

      assert index_live |> element("#campaigns-#{campaign.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#campaigns-#{campaign.id}")
    end
  end

  describe "Show" do
    test "displays campaign", %{conn: conn} do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, _show_live, html} = live(conn, ~p"/campaigns/#{campaign}")

      assert html =~ "Show Campaign"
      assert html =~ campaign.description
    end

    test "updates campaign within modal", %{conn: conn} do
      user = user_fixture()
      campaign = campaign_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      {:ok, show_live, _html} = live(conn, ~p"/campaigns/#{campaign}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Campaign"

      assert_patch(show_live, ~p"/campaigns/#{campaign}/show/edit")

      assert show_live
             |> form("#campaign-form", campaign: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#campaign-form", campaign: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/campaigns/#{campaign}")

      html = render(show_live)
      assert html =~ "Campaign updated successfully"
      assert html =~ "some updated description"
    end
  end
end
