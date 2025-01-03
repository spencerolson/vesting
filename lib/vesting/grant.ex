defmodule Vesting.Grant do
  @keys [:name, :start, :units, :years, :every_x_months]
  @enforce_keys @keys
  defstruct @keys

  @type t :: %__MODULE__{
          name: String.t(),
          start: Date.t(),
          units: integer(),
          years: integer(),
          every_x_months: integer()
        }

  @type event :: {Date.t(), {integer(), [String.t()]}}
  @type report :: [event]

  @price_per_unit 23.60

  def add_events(grant, events \\ %{}) do
    add_events(grant, grant.start, events)
  end

  defp add_events(grant, date, events) do
    next_vest = next_vest(date, grant)
    final_vest = final_vest(grant)

    if Date.compare(next_vest, final_vest) == :gt do
      events
    else
      units = units_per_vest(grant)
      dollars = round(units * @price_per_unit)

      events =
        Map.update(
          events,
          next_vest,
          {dollars, [grant.name]},
          fn {sum, names} ->
            {sum + dollars, [grant.name | names]}
          end
        )

      add_events(grant, next_vest, events)
    end
  end

  defp final_vest(grant) do
    Date.shift(grant.start, year: grant.years)
  end

  defp next_vest(cur_date, grant) do
    Date.shift(cur_date, month: grant.every_x_months)
  end

  defp units_per_vest(grant) do
    num_vest_events = grant.years * 12 / grant.every_x_months
    grant.units / num_vest_events
  end
end
