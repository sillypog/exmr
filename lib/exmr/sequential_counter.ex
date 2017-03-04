defmodule SequentialCounter do
  def count_days_in_file(filename, global_acc) do
    # Get the file from S3
    # Stream it
    # Process json on each line
    # Extract days and put count somewhere
    # Write the output

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
end
