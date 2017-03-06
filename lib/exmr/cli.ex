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
        mod: :string,
        run: :string
      ]
    )
    options
  end

  defp process([mod: mod, dir: "small"]) do
    mod
    |> expand_mod
    |> Exmr.small
    |> IO.inspect
  end

  defp process([mod: mod, dir: "large"]) do
    mod
    |> expand_mod
    |> Exmr.large
    |> IO.inspect
  end

  defp process(_) do
    IO.puts "Unknown mod and dir arguments"
  end

  defp expand_mod(module) do
    String.capitalize(module) <> "Counter"
  end
end
