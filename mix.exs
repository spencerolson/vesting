defmodule Vesting.MixProject do
  use Mix.Project

  def project do
    [
      app: :vesting,
      description: "Calculates how much money you'll get, and when, based on vesting schedules.",
      version: "0.1.0",
      elixir: "~> 1.18",
      package: [
        files: ~w(grants.json.example lib .formatter.exs mix.exs README*),
        licenses: ["Apache-2.0"],
        links: %{"GitHub" => "https://github.com/spencerolson/vesting"}
      ],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        vesting: [
          steps: [&copy_to_overlays/1, :assemble, :tar]
        ]
      ]
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
      {:ex_doc, "~> 0.34", only: :dev, runtime: false}
    ]
  end

  defp copy_to_overlays(release) do
    filename = Application.fetch_env!(:vesting, :grants_file)

    case File.copy(filename, "rel/overlays/#{filename}") do
      {:ok, _} -> release
      {:error, reason} -> raise "\nFailed to copy file `#{filename}`\nReason: #{inspect(reason)}"
    end
  end
end
