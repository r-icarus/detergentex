defmodule DetergentexTest do
  use ExUnit.Case

  @wsdl_url "http://www.webservicex.net/convertVolume.asmx?WSDL"
  @action "ChangeVolumeUnit"
  @parameters ["100","dry","centiliter"]

  test "should make a call to a web service" do
    {:ok, _, response} = Detergentex.call(@wsdl_url, @action, @parameters)
    assert Enum.count(response) == 1
  end

  test "should create a wsdl model and accept it to do calls" do
    wsdl = Detergentex.init_model @wsdl_url
    
    assert Detergentex.is_wsdl wsdl

    {:ok, _, response} = Detergentex.call(wsdl, @action, @parameters)
    assert Enum.count(response) == 1
  end
end
