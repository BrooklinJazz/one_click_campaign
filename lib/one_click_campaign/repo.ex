defmodule OneClickCampaign.Repo do
  use Ecto.Repo,
    otp_app: :one_click_campaign,
    adapter: Ecto.Adapters.Postgres
end
