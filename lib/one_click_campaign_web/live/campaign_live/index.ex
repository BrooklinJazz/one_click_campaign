defmodule OneClickCampaignWeb.CampaignLive.Index do
  use OneClickCampaignWeb, :live_view

  alias OneClickCampaign.Campaigns
  alias OneClickCampaign.Campaigns.Campaign

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :campaigns, Campaigns.list_campaigns())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Campaign")
    |> assign(:campaign, Campaigns.get_campaign!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Campaign")
    |> assign(:campaign, %Campaign{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Campaigns")
    |> assign(:campaign, nil)
  end

  @impl true
  def handle_info({OneClickCampaignWeb.CampaignLive.FormComponent, {:saved, campaign}}, socket) do
    {:noreply, stream_insert(socket, :campaigns, campaign)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    campaign = Campaigns.get_campaign!(id)
    {:ok, _} = Campaigns.delete_campaign(campaign)

    {:noreply, stream_delete(socket, :campaigns, campaign)}
  end
end
