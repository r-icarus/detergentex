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

  def call(wsdl, method, params, options \\ []) do
    Detergentex.Client.call_service(wsdl, method, params, options)
  end

  def init_model(wsdl_url, prefix \\ 'p') do
    Detergentex.Client.init_model(wsdl_url, prefix)
  end

  def is_wsdl(wsdl) do
    Detergentex.Client.is_wsdl(wsdl)
  end

  def wsdl_operations(wsdl) do
    Detergentex.Client.wsdl_operations(wsdl)
  end
end
