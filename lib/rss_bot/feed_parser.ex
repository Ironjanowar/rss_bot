defmodule RssBot.FeedParser do
  def parse(xml) do
    with {:ok, document} <- Floki.parse_document(xml) do
      parse_document(document)
    end
  end

  defp parse_document(document) do
    title = parse_title(document)
    subtitle = parse_subtitle(document)
    feed_id = parse_feed_id(document)
    links = parse_links(document)
    feed_updated_at = parse_feed_updated_at(document)
    author = parse_author(document)
    entries = parse_entries(document)

    %{
      title: title,
      subtitle: subtitle,
      feed_id: feed_id,
      links: links,
      feed_updated_at: feed_updated_at,
      author: author,
      entries: entries
    }
  end

  defp parse_title(document), do: document |> Floki.find("feed > title") |> Floki.text()
  defp parse_subtitle(document), do: document |> Floki.find("feed > subtitle") |> Floki.text()
  defp parse_feed_id(document), do: document |> Floki.find("feed > id") |> Floki.text()
  defp parse_author(document), do: document |> Floki.find("feed > author > name") |> Floki.text()

  defp parse_feed_updated_at(document) do
    document
    |> Floki.find("feed > updated")
    |> Floki.text()
  end

  defp parse_links(document) do
    document
    |> Floki.find("feed > link")
    |> Enum.map(&Floki.attribute(&1, "href"))
    |> List.flatten()
  end

  defp parse_entries(document) do
    document
    |> Floki.find("feed > entry")
    |> Enum.map(&parse_entry/1)
  end

  defp parse_entry(entry_document) do
    title = parse_entry_title(entry_document)
    link = parse_entry_link(entry_document)
    entry_id = parse_entry_id(entry_document)
    published_at = parse_entry_published_at(entry_document)
    updated_at = parse_entry_updated_at(entry_document)
    html_content = parse_entry_html_content(entry_document)

    %{
      title: title,
      link: link,
      entry_id: entry_id,
      published_at: published_at,
      updated_at: updated_at,
      html_content: html_content
    }
  end

  defp parse_entry_title(document), do: document |> Floki.find("entry > title") |> Floki.text()
  defp parse_entry_id(document), do: document |> Floki.find("entry > id") |> Floki.text()

  defp parse_entry_html_content(document),
    do: document |> Floki.find("entry > content") |> Floki.text()

  defp parse_entry_published_at(document),
    do: document |> Floki.find("entry > published") |> Floki.text()

  defp parse_entry_updated_at(document),
    do: document |> Floki.find("entry > updated") |> Floki.text()

  defp parse_entry_link(document),
    do: document |> Floki.find("entry > link") |> Floki.attribute("href")
end
