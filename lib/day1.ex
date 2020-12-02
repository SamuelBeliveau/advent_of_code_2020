defmodule AOC.Day1 do
  def solve_a do
    numbers = read_numbers()

    result =
      for(n1 <- numbers, n2 <- numbers, do: {n1, n2, n1 + n2})
      |> Enum.find(fn {_, _, total} -> total == 2020 end)

    case result do
      nil -> nil
      {n1, n2, _} -> n1 * n2
    end
  end

  def solve_b do
    numbers = read_numbers()

    result =
      for(n1 <- numbers, n2 <- numbers, n3 <- numbers, do: {n1, n2, n3, n1 + n2 + n3})
      |> Enum.find(fn {_, _, _, total} -> total == 2020 end)

    case result do
      nil -> nil
      {n1, n2, n3, _} -> n1 * n2 * n3
    end
  end

  defp read_numbers do
    {:ok, contents} = File.read("inputs/day1.txt")

    numbers =
      contents
      |> String.split("\r\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    [min | _] = numbers

    # Remove numbers that combined with the lowest possible value becomes too big
    numbers |> Enum.filter(fn n -> n + min <= 2020 end)
  end
end
