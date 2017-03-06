defmodule Exmr.ParallelCounter do
  def count_days_in_file(filename, global_acc) do
    filename
    |> File.stream!
    |> Flow.from_enumerable
    |> Flow.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse!
      |> Exmr.Timestamp.get_timestamps_from_json
    end)
    |> Flow.reduce(fn -> global_acc end, fn(day, acc) ->
      Map.update(acc, day, 1, &(&1 + 1))
    end)
    |> Enum.into(%{})
  end
end
