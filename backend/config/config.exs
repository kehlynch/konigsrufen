# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :konigsrufen,
  ecto_repos: [Konigsrufen.Repo]

# Configures the endpoint
config :konigsrufen, KonigsrufenWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q0lyAZWZjtqG4QPfvwDrgGU49o35H5oWJmAWZtbJ9jCyAH1kphlBAoPI8ItX4IqQ",
  render_errors: [view: KonigsrufenWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Konigsrufen.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
