defmodule DetergentexTest do
  use ExUnit.Case

  test "should make a call to a web service" do
    {:ok, _, response} = Detergentex.call("http://www.webservicex.net/convertVolume.asmx?WSDL","ChangeVolumeUnit", ["100","dry","centiliter"])
    assert Enum.count(response) == 1
  end
end
