defmodule LivemanWeb.V1.SurveyRequestTest do
  use LivemanWeb.ConnCase, async: true

  describe "GET /v1/surveys" do
    test "returns 200 status when request successfully", %{conn: conn} do
      conn = get(conn, Routes.api_v1_survey_path(conn, :index))

      assert conn.status == 200
    end

    test "returns 200 status when request with page_number and page_size", %{conn: conn} do
      conn = get(conn, Routes.api_v1_survey_path(conn, :index), page: 1, page_size: 8)

      assert conn.status == 200
    end
  end
end
