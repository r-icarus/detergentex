Detergentex
===========

An Elixir client for SOAP Services using the erlang detergent library.

## Usage
1) Add detergentex and its erlang dependencies to your deps:

```elixir
{:erlsom, github: "willemdj/erlsom"},
{:detergentex, "0.0.3"}
```

2) Add `:detergentex` to the list of application dependencies in your `mix.exs`.

```elixir
  def application do
    [applications: [:logger, :detergentex]]
  end
```

3) Call web services using `Detergentex.call(wsdl, method, parameters)`:

```elixir
wsdl_url = "http://www.webservicex.net/convertVolume.asmx?WSDL"
action = "ChangeVolumeUnit"
parameters = ["100","dry","centiliter"]

Detergentex.call(wsdl_url, action, parameters)

# Cache the wsdl to do recurrent calls quickly
wsdl = Detergentex.init_model(wsdl_url)

Detergentex.call(wsdl, action, parameters)
Detergentex.call(wsdl, action, parameters)
Detergentex.call(wsdl, action, parameters)
```

## License
MIT
