defmodule Vesting.Printer do
  @spec print_report(any()) :: :ok
  def print_report(report) when not is_list(report) do
    IO.puts("Invalid grants file. The grants file must contain a JSON array of grants.")
  end

  @spec print_report([]) :: :ok
  def print_report([]) do
    IO.puts(
      "No grants found. Did you create a #{Application.fetch_env!(:vesting, :grants_file)} file with grant info in the application root dir?"
    )
  end

  @spec print_report(Vesting.Grant.report()) :: :ok
  def print_report(report) do
    Enum.each(report, &print_event/1)
  end

  @spec print_event(Vesting.Grant.event()) :: :ok
  defp print_event({date, {dollars, names}}) do
    date = format_date(date)
    dollars = "$#{add_commas(dollars)}"
    grant_count = Enum.count(names)
    grant_word = if grant_count == 1, do: "grant", else: "grants"
    IO.puts("#{date}: #{dollars} (#{grant_count} #{grant_word} vesting)")
  end

  defp format_date(date) do
    Calendar.strftime(date, "%b %d, %Y")
  end

  defp add_commas(number) do
    number
    |> Integer.to_string()
    |> String.reverse()
    |> String.replace(~r/(.{3})/, "\\1,")
    |> String.reverse()
    |> String.replace(~r/^,/, "")
  end
end
