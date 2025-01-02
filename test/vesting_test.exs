defmodule VestingTest do
  use ExUnit.Case
  doctest Vesting

  test "generates a report" do
    assert Vesting.run() == ""
  end
end
