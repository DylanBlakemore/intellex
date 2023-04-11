defmodule Intellex.MixProject do
  use Mix.Project

  def project do
    [
      app: :intellex,
      version: "0.0.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mods: mods(Mix.env())
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp mods(:test), do: [Intellex.MockServer]
  defp mods(_), do: []

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:httpoison, "~> 1.8"},
      {:ex_doc, ">= 0.29.4", only: :dev},
      {:plug, "~> 1.12", only: :test},
      {:plug_cowboy, "~> 2.5", only: :test},
      {:openai, "~> 0.4.1"}
    ]
  end
end
