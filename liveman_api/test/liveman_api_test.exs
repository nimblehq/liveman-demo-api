defmodule LivemanApiTest do
  use ExUnit.Case

  describe "get/3" do
    test "returns a response given a URL" do
      client = LivemanApi.client("http://localhost:4000")

      assert {:ok,
              %{
                "data" => %{
                  "attributes" => %{
                    "avatar_url" => "https://source.boringavatars.com/bauhaus/120/",
                    "email" => _
                  },
                  "id" => _,
                  "links" => %{
                    "self" => _
                  },
                  "relationships" => %{},
                  "type" => "user"
                },
                "included" => [],
                "links" => %{
                  "self" => _
                }
              }} = LivemanApi.get(client, "/v1/me")
    end
  end
end
