defmodule OneClickCampaignWeb.CampaignLive.Show do
  use OneClickCampaignWeb, :live_view

  alias OneClickCampaign.Campaigns

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"campaign_id" => campaign_id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:campaign, Campaigns.get_campaign!(campaign_id))}
  end

  defp page_title(:show), do: "Show Campaign"
  defp page_title(:edit), do: "Edit Campaign"
end
