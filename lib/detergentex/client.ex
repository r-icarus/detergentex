defmodule Detergentex.Client do
  use GenServer

  def start_link do
    :inets.start()
    GenServer.start_link(__MODULE__, {}, [name: :detergent_client])
  end

  def call_service(wsdl_url, method, params) do
    detergent_params = Enum.map(params, fn(elem) -> to_char_list(elem) end)
    :detergent.call(to_char_list(wsdl_url), to_char_list(method), detergent_params)
  end  
end
