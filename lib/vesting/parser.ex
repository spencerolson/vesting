defmodule Vesting.Parser do
  def parse_grants do
    :vesting
    |> Application.fetch_env!(:grants_file)
    |> File.read()
    |> parse_json()
    |> Enum.map(&parse_grant/1)
  end

  defp parse_json({:ok, json}), do: JSON.decode!(json)
  defp parse_json({:error, :enoent}), do: []

  defp parse_grant(grant) do
    %Vesting.Grant{
      name: grant["name"],
      start: Date.from_iso8601!(grant["start"]),
      units: grant["units"],
      years: grant["years"],
      every_x_months: grant["every_x_months"]
    }
  end
end
