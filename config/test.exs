import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :utrust, UtrustWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "0Wh1he2to+H0bGNogLaivR9jen1lZAx4kpnTBRK0IpwmUf/UzoMhCwwcfln98ZKB",
  server: false

# In test we don't send emails.
config :utrust, Utrust.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
