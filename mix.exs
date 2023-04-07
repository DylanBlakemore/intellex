defmodule Hexling.MixProject do
  use Mix.Project

  def project do
    [
      app: :hexling,
      version: "0.0.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:httpoison, "~> 2.1.0"},
      {:ex_doc, ">= 0.29.4", only: :dev}
    ]
  end
end
