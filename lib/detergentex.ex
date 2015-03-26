defmodule Detergentex do
  use Application

  def start(_type, _args) do
      import Supervisor.Spec, warn: false
      children = [
        worker(Detergentex.Client, []),
      ]
      opts = [strategy: :one_for_one, name: Detergentex.Supervisor]
      Supervisor.start_link(children, opts)
  end

  def call(wsdl_url, method, params) do
    response = Detergentex.Client.call_service(wsdl_url, method, params)
    response
  end
end
