defmodule Twitch do
  use HTTPoison.Base

  @streams_key "streams"
  @stream_fields ~w(preview viewers channel)
  @api_version "v3"
  @client_id "qaq3wy6p6g1p7hp7d90qwgpg6adkrez"

  def process_url(url) do
    "https://api.twitch.tv/kraken" <> url
  end

  defp process_request_headers(headers) when is_map(headers) do
    Enum.into(headers, [{:accepts, "application/vnd.twitchtv.#{@api_version}+json"}, {:client_id, @client_id}])
  end

  defp process_request_headers(headers) do
    Enum.into(headers, [{:accepts, "application/vnd.twitchtv.#{@api_version}+json"}, {:client_id, @client_id}])
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> Map.get(@streams_key)
    |> Enum.map(fn(s) ->
        Dict.take(s, @stream_fields)
      end)
  end
end
