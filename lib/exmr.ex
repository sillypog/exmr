defmodule Exmr do
  def small(run_module) do
    module = Module.concat(Exmr, run_module)

    ["events/1.txt", "events/2.txt"]
    |> Enum.reduce(%{}, fn(filename, acc) ->
      apply(module, :count_days_in_file, [filename, acc])
    end)
  end

  def large(run_module) do
    module = Module.concat(Exmr, run_module)

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
      apply(module, :count_days_in_file, [filename, acc])
    end)
  end

  def enumerables(run_module) do
    module = Module.concat(Exmr, run_module)

    streams = for file <- File.ls!("events/large") do
      File.stream!("events/large/#{file}", read_ahead: 100_000)
    end

    apply(module, :count_days_in_files, [streams])
  end
end
