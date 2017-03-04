defmodule Exmr do
  def sequential_count_events_per_day do
    ["events/1.txt", "events/2.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      SequentialCounter.count_days_in_file(filename, acc)
    end)
  end

  def parallel_count_events_per_day do
    ["events/1.txt", "events/2.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      ParallelCounter.count_days_in_file(filename, acc)
    end)
  end
end
