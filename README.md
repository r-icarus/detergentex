Detergentex
===========

An Elixir client for SOAP Services using the erlang detergent library.

## Usage
1) Add detergentex and its erlang dependencies to your deps:

```elixir
{:detergent, github: "devinus/detergent" },
{:erlsom, github: "willemdj/erlsom"},
{:detergentex, "0.0.1"}
```

2) Add `:detergentex` to the list of application dependencies in your `mix.exs`.

```elixir
  def application do
    [applications: [:logger, :detergentex]]
  end
```

3) Call web services using `Detergentex.call(wsdl, method, parameters)`:

```elixir
Detergentex.call("http://www.webservicex.net/convertVolume.asmx?WSDL","ChangeVolumeUnit", ["100","dry","centiliter"])
```

## License
MIT
