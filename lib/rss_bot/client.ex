defmodule RssBot.Client do
  use Tesla

  def get_feed(feed_url) do
    with {:ok, %{body: body}} <- get(feed_url) do
      {:ok, body}
    end
  end
end
