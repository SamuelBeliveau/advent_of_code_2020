defmodule AOC.Day5 do
  def solve_a() do
    lines = AOC.Utilities.read_lines("inputs/day5.txt")

    lines
    |> Enum.map(&parse_seat/1)
    |> Enum.max()
  end

  def solve_b() do
    lines = AOC.Utilities.read_lines("inputs/day5.txt")

    seat_ids =
      lines
      |> Enum.map(&parse_seat/1)

    {min, max} = seat_ids |> Enum.min_max()

    Enum.filter(min..max, fn el -> !Enum.member?(seat_ids, el) end)
  end

  def parse_seat(ticket) do
    normalized = ticket |> String.replace(~r/[FL]/, "-") |> String.replace(~r/[BR]/, "+")
    {rows, columns} = String.split_at(normalized, 7)
    row = parse_row(rows |> String.graphemes(), 0, 127)
    column = parse_row(columns |> String.graphemes(), 0, 7)
    row * 8 + column
  end

  def parse_row(rows, min, max) when length(rows) > 0 do
    [row | rest] = rows
    distance = max - min

    case row do
      "-" -> parse_row(rest, min, max - div(distance, 2) - 1)
      "+" -> parse_row(rest, min + div(distance, 2) + 1, max)
    end
  end

  def parse_row(rows, min, _) when length(rows) == 0 do
    min
  end
end
