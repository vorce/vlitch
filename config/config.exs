# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :vlitch, Vlitch.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "hJmM0Z3R2XyINmkRbH7WD84eavYQVDl4cVxrmC2cS0srB9ZN4OXi21+antj7OwlJ",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Vlitch.PubSub,
           adapter: Phoenix.PubSub.PG2],
  twitch_base_url: "https://api.twitch.tv/kraken",
  twitch_client_id: "qaq3wy6p6g1p7hp7d90qwgpg6adkrez"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
