defmodule AOC.Day6 do
  def solve_a() do
    groups = read_groups()

    groups
    |> Enum.map(fn group ->
      group |> Enum.join() |> String.graphemes() |> Enum.uniq() |> Enum.count()
    end)
    |> Enum.sum()
  end

  def solve_b() do
    groups = read_groups()

    groups
    |> Enum.map(fn group ->
      length = length(group)
      freq = group |> Enum.join() |> String.graphemes() |> Enum.frequencies()
      {length, freq}
    end)
    |> Enum.map(fn {length, freq} ->
      freq |> Map.keys() |> Enum.filter(fn k -> freq[k] == length end) |> Enum.count()
    end)
    |> Enum.sum()
  end

  def read_groups() do
    {:ok, contents} = File.read("inputs/day6.txt")

    contents
    |> String.split("\r\n\r\n", trim: true)
    |> Enum.map(fn line -> String.split(line, "\r\n", trim: true) end)
  end
end
