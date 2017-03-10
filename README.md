# Exmr

Examples of using Elixir's Flow module to process event logs.

Small event files are provided in the events directory. These don't demonstrate the benefits and quirks of working with Flow very well. Use these as a template to generate much larger files in the events/large directory.

Examples can be run from the command line by building the exmr CLI application with `mix escript.build`. This can then be run as `./exmr --mod=sequential --dir=large`. Options for the `mod` parameter are `sequential`, `parallel`, `partition` and `group`. Options for the `dir` parameter are `small`, `large`, and `enumerables`. Outputs for each of these combinations are provided in timing.txt.

The application can be run in Docker with:
`docker build -t exmr .`
`docker run --ti --rm -v $(pwd):/app exmr /bin/bash`

