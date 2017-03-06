defmodule Exmr do
  def sequential_count_events_per_day do
    ["events/1.txt", "events/2.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      Exmr.SequentialCounter.count_days_in_file(filename, acc)
    end)
  end

  def parallel_count_events_per_day do
    ["events/1.txt", "events/2.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      Exmr.ParallelCounter.count_days_in_file(filename, acc)
    end)
  end

  def large_sequential_count_events_per_day do
    [
      "events/large/BR_Team_Stream_20161001002001119165_33983.txt",
      "events/large/BR_Team_Stream_20170201090629532694_53405.txt",
      "events/large/BR_Team_Stream_20170202190023528325_18142.txt",
      "events/large/BR_Team_Stream_20170203085832003614_43318.txt",
      "events/large/BR_Team_Stream_20170203121831043121_98717.txt",
      "events/large/BR_Team_Stream_20170204181255161562_56751.txt",
      "events/large/BR_Team_Stream_20170206030156471446_28986.txt"
    ]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      Exmr.SequentialCounter.count_days_in_file(filename, acc)
    end)
  end

  def large_parallel_count_events_per_day do
    [
      "events/large/BR_Team_Stream_20161001002001119165_33983.txt",
      "events/large/BR_Team_Stream_20170201090629532694_53405.txt",
      "events/large/BR_Team_Stream_20170202190023528325_18142.txt",
      "events/large/BR_Team_Stream_20170203085832003614_43318.txt",
      "events/large/BR_Team_Stream_20170203121831043121_98717.txt",
      "events/large/BR_Team_Stream_20170204181255161562_56751.txt",
      "events/large/BR_Team_Stream_20170206030156471446_28986.txt"
    ]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      Exmr.ParallelCounter.count_days_in_file(filename, acc)
    end)
  end
end
