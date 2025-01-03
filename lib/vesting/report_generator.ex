defmodule Vesting.ReportGenerator do
  @spec generate_report([Vesting.Grant.t()]) :: Vesting.Grant.report()
  def generate_report(grants) do
    grants
    |> Enum.reduce(%{}, &Vesting.Grant.add_events/2)
    |> Enum.sort(&ascending/2)
  end

  defp ascending({date1, _}, {date2, _}), do: Date.compare(date1, date2) != :gt
end
