defmodule MontyHallParadox.Mixfile do
  use Mix.Project

  def project do
    [
      app: :monty_hall_paradox,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Mhp.Application, []}
    ]
  end

  defp deps do
    [
    ]
  end

end
