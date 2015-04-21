defmodule Detergentex.Client do
  use GenServer

  def start_link do
    :inets.start()
    GenServer.start_link(__MODULE__, {}, [name: :detergent_client])
  end

  def call_service(wsdl, method, params) do
    if not is_wsdl(wsdl) do
      wsdl = to_char_list wsdl
    end
    detergent_params = Enum.map(params, fn(elem) -> to_char_list(elem) end)
    :detergent.call(wsdl, to_char_list(method), detergent_params)
  end

  def init_model(wsdl_url, prefix \\ 'p') do
    :detergent.initModel(to_char_list(wsdl_url), to_char_list(prefix))
  end

  def is_wsdl(wsdl), do: :detergent.is_wsdl(wsdl)
end
