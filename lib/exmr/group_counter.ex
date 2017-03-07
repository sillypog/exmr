defmodule Exmr.GroupCounter do
  def count_days_in_file(filename, global_acc) do
    filename
    |> File.stream!
    |> Flow.from_enumerable
    |> Flow.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse!
      |> Exmr.Timestamp.get_timestamps_from_json
      # Since each line has multiple timestamps, have to combine these into a single key for grouping later
      |> Enum.reduce(%{}, fn(day, acc) ->
        Map.update(acc, day, 1, &(&1 + 1))
      end)
      |> Map.to_list
    end)
    |> Flow.group_by_key
    |> Flow.emit(:state)
    |> Enum.map(fn(set) ->
      # Each set is a map of days where the value is an array of counts
      # Want to sum those counts
      Enum.reduce(set, %{}, fn({day, values}, acc) ->
        Map.put(acc, day, Enum.reduce(values, 0, fn(value, acc) -> acc + value end))
      end)
    end)
    # Now we have a list of maps
    |> Enum.reduce(global_acc, fn(set, acc) ->
      Map.merge(acc, set, fn(_k, v1, v2) ->
        v1 + v2
      end)
    end)
  end

  def count_days_in_files(streams) do
    streams
    |> Flow.from_enumerables
    |> Flow.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse!
      |> Exmr.Timestamp.get_timestamps_from_json
      # Since each line has multiple timestamps, have to combine these into a single key for grouping later
      |> Enum.reduce(%{}, fn(day, acc) ->
        Map.update(acc, day, 1, &(&1 + 1))
      end)
      |> Map.to_list
    end)
    |> Flow.group_by_key
    |> Flow.emit(:state)
    |> Enum.map(fn(set) ->
      # Each set is a map of days where the value is an array of counts
      # Want to sum those counts
      Enum.reduce(set, %{}, fn({day, values}, acc) ->
        Map.put(acc, day, Enum.reduce(values, 0, fn(value, acc) -> acc + value end))
      end)
    end)
    # Now we have a list of maps
    |> Enum.reduce(%{}, fn(set, acc) ->
      Map.merge(acc, set, fn(_k, v1, v2) ->
        v1 + v2
      end)
    end)
  end
end
