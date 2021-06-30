defmodule LivemanWeb.V1AnswerRequestTest do
  use LivemanWeb.ConnCase, async: true

  describe "POST /v1/responses" do
    test "returns 201 status when the survey_id param is valid", %{conn: conn} do
      attrs = %{
        survey_id: "d5de6a8f8f5f1cfe51bc",
        questions: [
          %{
            id: "940d229e4cd87cd1e202",
            answers: [
              %{
                id: "037574cb93d16800eecd"
              }
            ]
          }
        ]
      }

      conn = post(conn, Routes.api_v1_answer_path(conn, :create), attrs)

      assert conn.status == 201
    end

    test "returns 422 status when the survey_id param is invalid", %{conn: conn} do
      attrs = %{
        survey_id: "invalid",
        questions: [
          %{
            id: "940d229e4cd87cd1e202",
            answers: [
              %{
                id: "037574cb93d16800eecd"
              }
            ]
          }
        ]
      }

      conn = post(conn, Routes.api_v1_answer_path(conn, :create), attrs)

      assert conn.status == 422
    end

    test "returns 422 status when there is no survey_id param", %{conn: conn} do
      attrs = %{
        questions: [
          %{
            id: "940d229e4cd87cd1e202",
            answers: [
              %{
                id: "037574cb93d16800eecd"
              }
            ]
          }
        ]
      }

      conn = post(conn, Routes.api_v1_answer_path(conn, :create), attrs)

      assert conn.status == 422
    end

    test "returns 422 status when there is no question param", %{conn: conn} do
      attrs = %{
        survey_id: "d5de6a8f8f5f1cfe51bc"
      }

      conn = post(conn, Routes.api_v1_answer_path(conn, :create), attrs)

      assert conn.status == 422
    end
  end
end
