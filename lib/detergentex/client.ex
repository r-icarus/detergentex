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
    method_to_call = to_char_list(method)
    detergent_params = convert_to_detergent_params(params)
    :detergent.call(wsdl, method_to_call, detergent_params)
  end

  def init_model(wsdl_url, prefix \\ 'p') do
    :detergent.initModel(to_char_list(wsdl_url), to_char_list(prefix))
  end

  def is_wsdl(wsdl), do: :detergent.is_wsdl(wsdl)

  def wsdl_operations(wsdl), do: :detergent.wsdl_operations(wsdl)

  def convert_to_detergent_params(params) do
    Enum.map(params, fn(elem) ->
        case elem do
          elem when is_list(elem) ->
            convert_to_detergent_params(elem)
          elem when is_tuple(elem) ->
            elem
              |> Tuple.to_list
              |> convert_to_detergent_params
              |> List.to_tuple
          elem when is_binary(elem) ->
            to_char_list(elem)
          _ ->
            elem
        end
    end)
  end
end
