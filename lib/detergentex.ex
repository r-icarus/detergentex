defmodule Detergentex do
  def call(wsdl_url, method, params) do
    :inets.start()
    detergent_params = Enum.map(params, fn(elem) -> to_char_list(elem) end)
    :detergent.call(to_char_list(wsdl_url), to_char_list(method), detergent_params)
  end
end
