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

  def large_sequential_count_events_per_day do
    ["events/large/BR_Team_Stream_20161001002001119165_33983.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      SequentialCounter.count_days_in_file(filename, acc)
    end)
  end

  def large_parallel_count_events_per_day do
    ["events/large/BR_Team_Stream_20161001002001119165_33983.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      ParallelCounter.count_days_in_file(filename, acc)
    end)
  end
end
