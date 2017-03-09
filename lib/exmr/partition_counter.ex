defmodule Exmr.PartitionCounter do
  def count_days_in_file(filename, global_acc) do
    filename
    |> File.stream!
    |> Flow.from_enumerable
    |> build_flow(global_acc)
  end

  def count_days_in_files(streams) do
    streams
    |> Flow.from_enumerables
    |> build_flow(%{})
  end

  defp build_flow(flow, final_acc) do
    flow
    |> Flow.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse!
      |> Exmr.Timestamp.get_timestamps_from_json
    end)
    |> Flow.partition #(stages: 1) # But the list just looks like ["2016-10-01", "2016-10-01", "2016-10-01", "2016-10-01", "2016-10-01", ...]
    |> Flow.reduce(fn -> final_acc end, fn(day, acc) ->
      Map.update(acc, day, 1, &(&1 + 1))
    end)
    |> Enum.into(%{})
  end
end
