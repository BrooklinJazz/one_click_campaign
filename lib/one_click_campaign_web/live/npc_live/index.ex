defmodule OneClickCampaignWeb.NPCLive.Index do
  use OneClickCampaignWeb, :live_view

  alias OneClickCampaign.NPCs
  alias OneClickCampaign.NPCs.NPC

  use ExOpenAI.StreamingClient

  @impl true
  # callback on data
  def handle_data(data, socket) do
    %ExOpenAI.Components.CreateChatCompletionResponse{
      choices: choices
    } = data

    content =
      case choices do
        [%{delta: %{content: content}}] ->
          content

          {
            :noreply,
            socket
            |> assign(:id, socket.assigns.id + 1)
            |> assign(:description, socket.assigns.description <> content)
            |> stream_insert(:description, %{id: "#{socket.assigns.id}", word: content})
          }

        other ->
          {:noreply, socket}
      end
  end

  @impl true
  # callback on error
  def handle_error(e, socket) do
    IO.puts("got error: #{inspect(e)}")
    {:noreply, socket}
  end

  @impl true
  # callback on finish
  def handle_finish(socket) do
    IO.puts("finished!!")
    {:noreply, socket}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:description, "")
     |> assign(:id, 1)
     |> stream(:description, [])
     |> stream(:npcs, NPCs.list_npcs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Npc")
    |> assign(:npc, NPCs.get_npc!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Npc")
    |> assign(:npc, %NPC{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Npcs")
    |> assign(:npc, nil)
  end

  @impl true
  def handle_info({OneClickCampaignWeb.NPCLive.FormComponent, {:saved, npc}}, socket) do
    {:noreply, stream_insert(socket, :npcs, npc)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    npc = NPCs.get_npc!(id)
    {:ok, _} = NPCs.delete_npc(npc)

    {:noreply, stream_delete(socket, :npcs, npc)}
  end
end
