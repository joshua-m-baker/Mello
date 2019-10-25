# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :trello,
  ecto_repos: [Trello.Repo]

# Configures the endpoint
config :trello, TrelloWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "K6j2WuFNXtuCOjhRu9/jDzv3vISl6pWBmw9xKt74R+x6dieTTY0a2596TSscO1BT",
  render_errors: [view: TrelloWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Trello.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
