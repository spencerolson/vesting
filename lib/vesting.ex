defmodule Vesting do
  @moduledoc """
  The main Vesting module.
  """

  @doc """
  Prints the vesting dates and the amount that will be granted on that date.
  """
  def run do
    Vesting.Parser.parse_grants()
    |> Vesting.ReportGenerator.generate_report()
    |> Vesting.Printer.print_report()
  end
end
