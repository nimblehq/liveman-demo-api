defmodule LivemanWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error),
        class: "invalid-feedback",
        phx_feedback_for: input_name(form, field)
      )
    end)
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(LivemanWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(LivemanWeb.Gettext, "errors", msg, opts)
    end
  end

  def pretty_errors(errors) do
    errors
    |> Enum.map(&do_prettify/1)
  end

  defp do_prettify({field_name, message}) when is_bitstring(message) do
    human_field_name =
      field_name
      |> Atom.to_string()
      |> String.replace("_", " ")
      |> String.capitalize()

    human_field_name <> " " <> message
  end

  defp do_prettify({field_name, {message, variables}}) do
    compound_message = do_interpolate(message, variables)
    do_prettify({field_name, compound_message})
  end

  defp do_interpolate(string, [{name, value} | rest]) do
    n = Atom.to_string(name)
    msg = String.replace(string, "%{#{n}}", do_to_string(value))
    do_interpolate(msg, rest)
  end

  defp do_interpolate(string, []), do: string

  defp do_to_string(value) when is_integer(value), do: Integer.to_string(value)
  defp do_to_string(value) when is_bitstring(value), do: value
  defp do_to_string(value) when is_atom(value), do: Atom.to_string(value)
end
