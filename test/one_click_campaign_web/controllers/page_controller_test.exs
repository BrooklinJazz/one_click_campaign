defmodule OneClickCampaignWeb.PageControllerTest do
  use OneClickCampaignWeb.ConnCase
  import OneClickCampaign.AccountsFixtures

  test "GET /", %{conn: conn} do
    conn = log_in_user(conn, user_fixture())
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Peace of mind from prototype to production"
  end
end
