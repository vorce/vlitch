defmodule Vlitch.StreamController do
  use Vlitch.Web, :controller

  def index(conn, %{"game" => game}) do
    streams = retrieve_streams(game)
    render conn, "index.html", streams: streams, game: game
  end

  def retrieve_streams(game) do
    Twitch.start
    Twitch.get!("/streams?game=" <> String.replace(game, " ", "+")).body
  end
end
