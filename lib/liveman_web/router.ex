defmodule LivemanWeb.Router do
  use LivemanWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :require_authenticated_user do
    plug LivemanWeb.Plugs.Auth
  end

  # coveralls-ignore-start
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", LivemanWeb, as: :api_v1 do
    scope "/" do
      pipe_through :api

      scope "/users" do
        post "/signup", V1.UserController, :create
        post "/verify", V1.UserController, :verify
      end

      get "/surveys", V1.SurveyController, :index
    end

    scope "/" do
      pipe_through [:api, :require_authenticated_user]

      get "/me", V1.UserController, :show
      post "/responses", V1.AnswerController, :create
    end
  end

  # coveralls-ignore-stop

  scope "/", LivemanWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LivemanWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      # coveralls-ignore-start
      live_dashboard "/dashboard", metrics: LivemanWeb.Telemetry
      # coveralls-ignore-stop
    end
  end
end
