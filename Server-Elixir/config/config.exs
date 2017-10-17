# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :myapp,
  ecto_repos: [Myapp.Repo]

# Configures the endpoint
config :myapp, Myapp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "P8PGtvUscEbR67HkeRTQEfipXaKr7AaFYH++rOARF9j7ZoV6dz2xaCrtaEi0El4P",
  render_errors: [view: Myapp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Myapp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Myapp",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "P8PGtvUscEbR67HkeRTQEfipXaKr7AaFYH++rOARF9j7ZoV6dz2xaCrtaEi0El4P",
  serializer: Myapp.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
