defmodule RssBot.FeedParserTest do
  use ExUnit.Case, async: true

  alias RssBot.FeedParser

  test "works" do
    xml = load_xml("fly_feed.xml")

    parsed = FeedParser.parse(xml)

    assert parsed.title == "The Fly Phoenix Files"
    # TODO: assert more stuff
  end

  defp load_xml(path) do
    "test/fixtures/"
    |> Path.join(path)
    |> File.read!()
  end
end
