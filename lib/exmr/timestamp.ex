defmodule Exmr.Timestamp do
  def get_timestamps_from_json(json) do
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
