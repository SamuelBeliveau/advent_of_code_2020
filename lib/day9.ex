defmodule AOC.Day9 do
  def solve_a do
    lines = AOC.Utilities.read_lines("inputs/day9.txt")
    numbers = lines |> Enum.map(&String.to_integer/1)
    scan(numbers, 0)
  end

  def solve_b do
    lines = AOC.Utilities.read_lines("inputs/day9.txt")
    numbers = lines |> Enum.map(&String.to_integer/1)
    to_verify = scan(numbers, 0)
    verify_contiguous(numbers, 0..0, to_verify)
  end

  def scan(numbers, index) do
    preamble = numbers |> Enum.slice(index..(index + 24))
    number = numbers |> Enum.at(index + 25, nil)

    case verify(preamble, number) do
      :ok -> scan(numbers, index + 1)
      :error -> number
    end
  end

  def verify(_preamble, number) when is_nil(number) do
    :error
  end

  def verify(preamble, number) do
    matches =
      for(n1 <- preamble, n2 <- preamble, do: {n1, n2, n1 + n2})
      |> Enum.filter(fn {n1, n2, sum} -> n1 != n2 and sum == number end)

    if length(matches) == 0 do
      :error
    else
      :ok
    end
  end

  def verify_contiguous(numbers, first..last, number_to_check) do
    preamble = numbers |> Enum.slice(first..last)
    sum = preamble |> Enum.sum()

    cond do
      sum == number_to_check ->
        {:ok, Enum.min(preamble), Enum.max(preamble), Enum.min(preamble) + Enum.max(preamble)}

      sum > number_to_check ->
        verify_contiguous(numbers, Range.new(first + 1, first + 1), number_to_check)

      sum < number_to_check ->
        verify_contiguous(numbers, Range.new(first, last + 1), number_to_check)
    end
  end
end
