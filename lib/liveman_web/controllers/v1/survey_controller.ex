defmodule LivemanWeb.V1.SurveyController do
  use LivemanWeb, :controller

  alias Liveman.Survey.Surveys
  alias LivemanWeb.V1.SurveyView

  def index(conn, params) do
    page = Scrivener.paginate(Surveys.list_surveys(), build_pagination_config(params))

    render(conn, SurveyView, "index.json", %{data: page.entries, meta: meta_data(page)})
  end

  defp build_pagination_config(%{"page" => _page_number, "page_size" => _page_size} = params),
    do: params

  defp build_pagination_config(_params), do: %Scrivener.Config{page_number: 1, page_size: 5}

  defp meta_data(page) do
    %{
      page: page.page_number,
      pages: page.total_pages,
      page_size: page.page_size,
      records: page.total_entries
    }
  end
end
