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
    maybe_add_event(grant.start, grant, events)
  end

  defp maybe_add_event(date, grant, events) do
    next_vest = next_vest(date, grant)
    final_vest = final_vest(grant)
    today = Date.utc_today()

    cond do
      Date.compare(next_vest, final_vest) == :gt ->
        events

      Date.compare(next_vest, today) == :lt ->
        maybe_add_event(next_vest, grant, events)

      true ->
        add_event(next_vest, grant, events)
    end
  end

  defp add_event(date, grant, events) do
    units = units_per_vest(grant)
    dollars = round(units * @price_per_unit)

    new_events =
      Map.update(
        events,
        date,
        {dollars, [grant.name]},
        fn {sum, names} ->
          {sum + dollars, [grant.name | names]}
        end
      )

    maybe_add_event(date, grant, new_events)
  end

  defp final_vest(grant) do
    Date.shift(grant.start, year: grant.years)
  end

  defp next_vest(date, grant) do
    Date.shift(date, month: grant.every_x_months)
  end

  defp units_per_vest(grant) do
    num_vest_events = grant.years * 12 / grant.every_x_months
    grant.units / num_vest_events
  end
end
