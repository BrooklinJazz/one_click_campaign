defmodule OneClickCampaignWeb.CampaignLive.FormComponent do
  use OneClickCampaignWeb, :live_component

  alias OneClickCampaign.Campaigns

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage campaign records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="campaign-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:setting]} type="text" label="Setting" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:public]} type="checkbox" label="Public" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Campaign</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{campaign: campaign} = assigns, socket) do
    changeset = Campaigns.change_campaign(campaign)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"campaign" => campaign_params}, socket) do
    changeset =
      socket.assigns.campaign
      |> Campaigns.change_campaign(campaign_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"campaign" => campaign_params}, socket) do
    save_campaign(socket, socket.assigns.action, campaign_params)
  end

  defp save_campaign(socket, :edit, campaign_params) do
    case Campaigns.update_campaign(socket.assigns.campaign, campaign_params) do
      {:ok, campaign} ->
        notify_parent({:saved, campaign})

        {:noreply,
         socket
         |> put_flash(:info, "Campaign updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_campaign(socket, :new, campaign_params) do
    case Campaigns.create_campaign(campaign_params) do
      {:ok, campaign} ->
        notify_parent({:saved, campaign})

        {:noreply,
         socket
         |> put_flash(:info, "Campaign created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
