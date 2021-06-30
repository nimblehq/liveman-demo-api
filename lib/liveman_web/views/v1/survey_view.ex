defmodule LivemanWeb.V1.UserView do
  use JSONAPI.View, type: "survey"

  def fields do
    [:title, :description]
  end
end
