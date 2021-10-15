defmodule MaybePipe do
  @moduledoc """
  This is main module in MaybePipe library. Import it to take advantage of `<|>` operator.
  """

  @doc """
  This is the MaybePipe operator.
  """
  defmacro left <|> right do
    quote do
      with {:ok, val} <- unquote(left) do
        val |> unquote(right)
      end
    end
  end
end
