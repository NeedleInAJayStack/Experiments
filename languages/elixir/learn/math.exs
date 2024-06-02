defmodule Math do
  def sum(a, b) do
    cond do
      zero?(a) -> b
      zero?(b) -> a
      true -> do_sum(a, b)
    end
  end

  defp do_sum(a, b) do
    a + b
  end

  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end
