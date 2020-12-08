defmodule AOC.Day7 do
  def solve_a() do
    lines = AOC.Utilities.read_lines("inputs/day7.txt")
    bags = lines |> Enum.map(&parse_bag/1)
    find_parents(bags, "shiny gold") |> Enum.uniq() |> Enum.count()
  end

  def solve_b() do
    lines = AOC.Utilities.read_lines("inputs/day7.txt")
    bags_map = lines |> Enum.map(&parse_bag/1) |> Map.new()
    count_children(bags_map, "shiny gold")
  end

  def find_parents(bags, current_bag) do
    parents =
      bags
      |> Enum.filter(fn {_, content} ->
        content |> Enum.any?(fn {_, bag} -> bag == current_bag end)
      end)
      |> Enum.map(fn {source, _} -> source end)

    Enum.concat(parents, parents |> Enum.flat_map(fn parent -> find_parents(bags, parent) end))
  end

  def count_children(bags_map, current_bag) do
    bags_map[current_bag]
    |> Enum.map(fn {number, name} -> number + number * count_children(bags_map, name) end)
    |> Enum.sum()
  end

  def parse_bag(line) do
    [source, contents] = line |> String.split("contain", trim: true)
    [_, source] = Regex.run(~r/(.*) bags/, source)

    contents =
      contents
      |> String.split(",", trim: true)
      |> Enum.map(fn content ->
        case Regex.run(~r/([0-9]+) (.*) bag/, content) do
          [_, number, name] -> {String.to_integer(number), name}
          _ -> nil
        end
      end)
      |> Enum.reject(&is_nil/1)

    {source, contents}
  end
end
