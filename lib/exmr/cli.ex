defmodule Exmr.CLI do
  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [
        dir: :string,
        run: :string
      ]
    )
    options
  end

  defp process([dir: "events", run: "sequential"]) do
    IO.inspect Exmr.sequential_count_events_per_day()
  end

  defp process([dir: "events", run: "parallel"]) do
    IO.inspect Exmr.parallel_count_events_per_day()
  end

  defp process([dir: "large", run: "sequential"]) do
    IO.inspect Exmr.large_sequential_count_events_per_day()
  end

  defp process([dir: "large", run: "parallel"]) do
    IO.inspect Exmr.large_parallel_count_events_per_day()
  end

  defp process(_) do
    IO.puts "Unknown dir and run arguments"
  end
end
