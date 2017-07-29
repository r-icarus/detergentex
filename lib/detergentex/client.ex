defmodule Detergentex.Client do
  use GenServer
  require Record

  def default_logger(_), do: :ok

  original_record = Record.extract(:call_opts, from_lib: "detergent/include/detergent.hrl")
  call_opts_record = Keyword.merge(original_record, request_logger: &__MODULE__.default_logger/1, response_logger: &__MODULE__.default_logger/1)
  Record.defrecord :call_opts, call_opts_record

  def start_link do
    :inets.start()
    GenServer.start_link(__MODULE__, {}, [name: :detergent_client])
  end

  def call_service(wsdl, method, params, options \\ []) do
    wsdl = if not is_wsdl(wsdl) do
      to_charlist(wsdl)
    end
    method_to_call = to_char_list(method)
    detergent_params = convert_to_detergent_params(params)

    call_options = options
    |> convert_to_detergent_params
    |> call_opts_from_klist

    :detergent.call(wsdl, method_to_call, detergent_params, call_options)
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

  defp call_opts_from_klist(keywords) do
    call_options = call_opts()
    Enum.reduce(keywords, call_options, fn ({k,v}, acc) ->
      case k do
        :url -> call_opts(acc, url: v)
        :prefix -> call_opts(acc, prefix: v)
        :http_headers -> call_opts(acc, http_headers: v)
        :http_client_options -> call_opts(acc, http_client_options: v)
        :request_logger -> call_opts(acc, request_logger: v)
        :response_logger -> call_opts(acc, response_logger: v)
      end
    end)
  end
end
