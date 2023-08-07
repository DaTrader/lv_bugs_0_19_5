import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lv_bugs_0_19_5, LvBugs0195Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5d+WGv0BExM2gImhZdzmzYQJ7NH6/6RpFo26gjZ2k5azC1c8B7D9+GdDWixLhY+w",
  server: false

# In test we don't send emails.
config :lv_bugs_0_19_5, LvBugs0195.Mailer,
  adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
