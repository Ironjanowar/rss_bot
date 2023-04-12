defmodule RssBot.Repo do
  use Ecto.Repo,
    otp_app: :rss_bot,
    adapter: Ecto.Adapters.Postgres
end
