defmodule Detergentex.Mixfile do
  use Mix.Project

  def project do
    [app: :detergentex,
     version: "0.0.2",
     elixir: "~> 1.0",
     deps: deps,
     package: [
      contributors: ["Ricardo Echavarria", "Jonas Trevisan"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/r-icarus/detergentex"}
     ],
     description: """
     Elixir binding to Detergent erlang library used to call WSDL/SOAP Services
     """]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :inets, :ssl],
      mod: {Detergentex, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:detergent, github: "devinus/detergent" },
      {:erlsom, github: "willemdj/erlsom"}
    ]
  end
end
