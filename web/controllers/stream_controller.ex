defmodule Vlitch.StreamController do
  use Vlitch.Web, :controller

  def index(conn, %{"game" => game}) do
    streams = Cache.get(game, fn(k) -> retrieve_streams(k) end, 120)
    render conn, "index.html", streams: streams, game: game
  end

  def retrieve_streams(game) do
    Twitch.get!("/streams?game=" <> URI.encode_www_form(game)).body
  end
end
