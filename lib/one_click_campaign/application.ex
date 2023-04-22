defmodule OneClickCampaign.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      OneClickCampaignWeb.Telemetry,
      # Start the Ecto repository
      OneClickCampaign.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: OneClickCampaign.PubSub},
      # Start Finch
      {Finch, name: OneClickCampaign.Finch},
      # Start the Endpoint (http/https)
      OneClickCampaignWeb.Endpoint
      # Start a worker by calling: OneClickCampaign.Worker.start_link(arg)
      # {OneClickCampaign.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OneClickCampaign.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OneClickCampaignWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
