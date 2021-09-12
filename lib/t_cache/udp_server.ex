defmodule TCache.UDPServer do
  require Logger

  def open(port), do: open(port, :inet)

  def open(port, family) do
    {:ok, socket} = :gen_udp.open(port, [:binary, family, active: false, reuseaddr: true])
    Logger.info "port opened at #{inspect socket}/#{port}"

    looper(socket)
  end

  def looper(socket) do
    Logger.info "enter looper"
    {:ok, data} = :gen_udp.recv(socket, 0)
    _pid = spawn(TCache.UDPServer, :echo_server, [socket, data])

    looper(socket)
  end

  def echo_server(socket, {host, port, data}) do
    Logger.info "echo server received: #{data} from #{inspect host}:#{port}"
    :ok = :gen_udp.send(socket, host, port, "received: #{data}")
  end
end
