defmodule Exmr do
  alias Experimental.Flow

  def process_file(filename) do
    # Get the file from S3
    # Stream it
    # Process json on each line
    # Extract days and put count somewhere
    # Write the output

    filename
    |> File.stream!
    |> Stream.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse
      |> get_timestamps
    end)
    |> Enum.reduce(%{}, fn(day, acc) ->
      Map.update(acc, day, 1, &(&1 + 1))
    end)
  end

  def flow_file(filename) do
    filename
    |> File.stream!
    |> Flow.from_enumerable
    |> Flow.flat_map(fn(line) ->
      line
      |> Poison.Parser.parse
      |> get_timestamps
    end)
    |> Flow.reduce(fn -> %{} end, fn(day, acc) ->
      Map.update(acc, day, 1, &(&1 + 1))
    end)
    |> Enum.into(%{})
  end

  defp get_timestamps({:ok, json}) do
    json
    |> Map.get("events")
    |> Enum.map(fn(event) ->
      event
      |> Map.get("data")
      |> Map.get("timestamp_unixtime_ms")
      |> timestamp_to_day
    end)
  end

  defp timestamp_to_day(timestamp) do
    timestamp
    |> DateTime.from_unix!(:milliseconds)
    |> DateTime.to_date
    |> Date.to_string
  end
end
