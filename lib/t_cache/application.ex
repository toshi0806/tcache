defmodule TCache.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    port = String.to_integer(System.get_env("TCACHE_PORT") || "53")

    children = [
      {TCache.UDPServerTask, port}
    ]

    opts = [strategy: :one_for_one, name: TCache.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
