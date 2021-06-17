# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

if config_env() == :prod do
  config :liveman, Centauri.Repo,
    ssl: true,
    url: System.fetch_env!("DATABASE_URL"),
    pool_size: String.to_integer(System.get_env("DATABASE_POOL_SIZE") || "10")

  config :liveman, CentauriWeb.Endpoint,
    http: [
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    url: [
      host: System.fetch_env!("HOST"),
      port: String.to_integer(System.fetch_env!("PORT"))
    ],
    secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
    server: true
end
