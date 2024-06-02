defmodule Recursion do
  ## Multiple prints

  # Main entry function
  def print_multiple_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_multiple_times(msg, n - 1)
  end

  # Exit base-case
  def print_multiple_times(_msg, 0) do
    :ok
  end

  ## Sum a list of numbers

  def sum_list([head | tail], acc) do
    sum_list(tail, head + acc)
  end

  def sum_list([], acc) do
    acc
  end

  ## Double a list of numbers

  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

# Recursion.print_multiple_times("Hello", 3)
# Recursion.sum_list([1, 2, 3], 0)
# Recursion.double_each([1, 2, 3])
