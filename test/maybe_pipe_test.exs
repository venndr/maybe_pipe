defmodule MaybePipeTest do
  use ExUnit.Case
  doctest MaybePipe

  import MaybePipe

  test "when calling with one pipe and {:ok, v}" do
    assert {:ok, 13} == {:ok, 10} <|> (fn x, y, z -> {:ok, x + y + z} end).(1, 2)
  end

  test "when calling with two pipes and {:error, v}" do
    assert {:error, 10} ==
             {:error, 10} <|> (fn x, y, z -> {:ok, x + y + z} end).(1, 2) <|> Kernel.+(1)
  end

  test "when calling with two pipes and {:ok, v}" do
    assert 14 == {:ok, 10} <|> (fn x, y, z -> {:ok, x + y + z} end).(1, 2) <|> Kernel.+(1)
  end

  test "when calling with two pipes and one ok and one error" do
    assert {:error, 13} ==
             {:ok, 10} <|> (fn x, y, z -> {:error, x + y + z} end).(1, 2) <|> Kernel.+(1)
  end

  test "when calling with two pipes and v" do
    assert 10 == 10 <|> (fn x, y, z -> {:ok, x + y + z} end).(1, 2) <|> Kernel.+(1)
  end

  test "when calling with broken pipe and v" do
    assert 13 == {:ok, 10} <|> (fn x, y, z -> x + y + z end).(1, 2) <|> Kernel.+(1)
  end

  test "unpack value" do
    assert 13 == {:ok, 10} <|> (fn x, y, z -> {:ok, x + y + z} end).(1, 2) <|> (& &1).()
  end
end
