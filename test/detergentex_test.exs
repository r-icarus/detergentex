defmodule DetergentexTest do
  use ExUnit.Case

  @wsdl_url "http://www.webservicex.net/convertVolume.asmx?WSDL"
  @action "ChangeVolumeUnit"
  @parameters ["100","dry","centiliter"]

  test "should make a call to a web service" do
    {:ok, _, response} = Detergentex.call(@wsdl_url, @action, @parameters)
    assert Enum.count(response) == 1
  end

  test "should process lists with nested lists" do
    params = [ "name", "Fulano", "skills" , ["jumping", 20, "running", 90]]
    result = [ 'name', 'Fulano', 'skills' , ['jumping', 20, 'running', 90]]
    assert result == Detergentex.Client.convert_to_detergent_params(params)
  end

  test "should create a wsdl model and accept it to do calls" do
    wsdl = Detergentex.init_model @wsdl_url

    assert Detergentex.is_wsdl wsdl

    {:ok, _, response} = Detergentex.call(wsdl, @action, @parameters)
    assert Enum.count(response) == 1
  end

  test "should be able to get the list of wsdl operations from the service" do
    wsdl = Detergentex.init_model(@wsdl_url)
    ops_list = [ head | _ ] = Detergentex.wsdl_operations(wsdl)

    assert Enum.count(ops_list) > 0
    assert (head |> Tuple.to_list |> Enum.count) == 7
    assert elem(head, 0) == :operation
  end
end
