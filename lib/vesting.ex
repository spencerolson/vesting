defmodule Vesting do
  @moduledoc """
  The main Vesting module.
  """

  @doc """
  Prints the vesting dates and the amount that will be granted on that date.
  """
  def run do
    :vesting
    |> Application.fetch_env!(:grants_file)
    |> File.read()
    |> parse_grants()
    |> print_grants()
  end

  defp parse_grants({:ok, json}), do: JSON.decode!(json)
  defp parse_grants({:error, :enoent}), do: []

  defp print_grants(grants) when not is_list(grants) do
    IO.puts("Invalid grants file. The grants file must contain a JSON array of grants.")
  end

  defp print_grants([]) do
    IO.puts(
      "No grants found. Did you create a #{Application.fetch_env!(:vesting, :grants_file)} file with grant info in the application root dir?"
    )
  end

  defp print_grants(grants) do
    Enum.each(grants, fn grant ->
      IO.puts("On #{grant["start"]}, you were granted #{grant["amount"]} shares.")
    end)
  end
end
