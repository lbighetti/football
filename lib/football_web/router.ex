defmodule FootballWeb.Router do
  @moduledoc false
  use FootballWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FootballWeb do
    pipe_through :api

    get "/results/available", ResultController, :available
    get "/p/results/available", ResultController, :protobuf_available
    get "/results", ResultController, :index
    get "/p/results", ResultController, :protobuf_index
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :football, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0.0",
        title: "Football Results Api"
      }
    }
  end
end
