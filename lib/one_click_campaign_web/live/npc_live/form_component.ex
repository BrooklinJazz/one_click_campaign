defmodule OneClickCampaignWeb.NPCLive.FormComponent do
  use OneClickCampaignWeb, :live_component
  alias OneClickCampaign.NPCs

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage npc records in your database.</:subtitle>
      </.header>
      <.simple_form for={%{}} id="npc-prompt" phx-target={@myself} phx-submit="generate">
        <%!-- <.input field={@form[:prompt]} type="text" label="Prompt" /> --%>
        <.input name="prompt" value="" type="text" label="Prompt" />
        <:actions>
          <.button phx-disable-with="Generating...">Generate</.button>
        </:actions>
      </.simple_form>
      <.simple_form
        for={@form}
        id="npc-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Npc</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{npc: npc} = assigns, socket) do
    changeset = NPCs.change_npc(npc)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"npc" => npc_params}, socket) do
    changeset =
      socket.assigns.npc
      |> NPCs.change_npc(npc_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"npc" => npc_params}, socket) do
    save_npc(socket, socket.assigns.action, npc_params)
  end

  def handle_event("generate", params, socket) do
    IO.inspect(params, label: "GENERATING")

    content =
      ExOpenAI.Chat.create_chat_completion(
        [%{role: "user", content: params["prompt"]}],
        "gpt-3.5-turbo",
        stream: true,
        stream_to: self()
      )

    #  {:ok, pid} = MyStreamingClient.start_link nil
    # ExOpenAI.Completions.create_completion "text-davinci-003", prompt: "hello world", stream: true, stream_to: pid
    IO.inspect(content, label: "MY API CONTENT")
    {:noreply, socket}
  end

  defp save_npc(socket, :edit, npc_params) do
    case NPCs.update_npc(socket.assigns.npc, npc_params) do
      {:ok, npc} ->
        notify_parent({:saved, npc})

        {:noreply,
         socket
         |> put_flash(:info, "Npc updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_npc(socket, :new, npc_params) do
    case NPCs.create_npc(npc_params) do
      {:ok, npc} ->
        notify_parent({:saved, npc})

        {:noreply,
         socket
         |> put_flash(:info, "Npc created successfully")
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
