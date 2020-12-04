defmodule AOC.Day3 do
  def solve_a() do
    x = 0
    y = 0
    rows = AOC.Utilities.read_lines("inputs/day3.txt")
    visited = slide(rows, x, y, 3, 1)
    visited |> count_trees
  end

  def solve_b() do
    x = 0
    y = 0
    rows = AOC.Utilities.read_lines("inputs/day3.txt")

    (slide(rows, x, y, 1, 1) |> count_trees) * (slide(rows, x, y, 3, 1) |> count_trees) *
      (slide(rows, x, y, 5, 1) |> count_trees) * (slide(rows, x, y, 7, 1) |> count_trees) *
      (slide(rows, x, y, 1, 2) |> count_trees)
  end

  defp count_trees(visited) do
    visited |> Enum.count(fn tile -> tile == "#" end)
  end

  defp slide(rows, x, y, h, v) when length(rows) > y do
    x = x + h
    y = y + v
    [get_tile(rows, x, y) | slide(rows, x, y, h, v)]
  end

  defp slide(_, _, _, _, _) do
    []
  end

  defp get_tile(rows, x, y) when length(rows) > y do
    row = Enum.at(rows, y) |> String.graphemes()
    columns_count = row |> length()
    row |> Enum.at(rem(x, columns_count))
  end

  defp get_tile(_, _, _) do
    []
  end
end
