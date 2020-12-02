defmodule AOC.Day2 do
  def solve_a do
    entries =
      AOC.Utilities.read_lines("inputs/day2.txt")
      |> Enum.map(&parse_line/1)

    entries |> Enum.filter(&is_valid_a/1) |> length()
  end

  def solve_b do
    entries =
      AOC.Utilities.read_lines("inputs/day2.txt")
      |> Enum.map(&parse_line/1)

    entries |> Enum.filter(&is_valid_b/1) |> length()
  end

  defp is_valid_a({min, max, char, password}) do
    count = password |> String.graphemes() |> Enum.count(fn c -> c == char end)
    count >= min and count <= max
  end

  defp is_valid_b({pos1, pos2, char, password}) do
    graphemes = password |> String.graphemes()

    first_char = graphemes |> Enum.at(pos1 - 1)
    second_char = graphemes |> Enum.at(pos2 - 1)

    (char == first_char and char != second_char) or
      (char != first_char and char == second_char)
  end

  defp parse_line(line) do
    [_, num1, num2, char, password] = Regex.run(~r/(\d+)-(\d+) ([a-z]): ([a-z]+)/, line)
    {String.to_integer(num1), String.to_integer(num2), char, password}
  end
end
