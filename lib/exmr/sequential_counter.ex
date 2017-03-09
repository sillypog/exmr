defmodule Exmr.SequentialCounter do
  def count_days_in_file(filename, global_acc) do
    filename
    |> File.stream!
    |> Stream.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse!
      |> Exmr.Timestamp.get_timestamps_from_json
    end)
    |> Enum.reduce(global_acc, fn(day, acc) ->
      Map.update(acc, day, 1, &(&1 + 1))
    end)
  end

  def count_days_in_files(_) do
    "`Stream.from_enumerables/1` does not exist"
  end
end
