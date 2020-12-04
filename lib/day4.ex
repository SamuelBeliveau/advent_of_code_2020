defmodule AOC.Day4 do
  def solve_a() do
    read_entries() |> Enum.count(&is_valid_a/1)
  end

  def solve_b() do
    read_entries() |> Enum.count(&is_valid_b/1)
  end

  def read_entries() do
    {:ok, contents} = File.read("inputs/day4.txt")
    lines = contents |> String.split("\r\n\r\n", trim: true)

    lines
    |> Enum.map(fn line ->
      line
      |> String.replace("\r\n", " ")
      |> String.split(" ", trim: true)
      |> Enum.map(fn entry ->
        [key, value] = entry |> String.split(":", trim: true)
        {key, value}
      end)
      |> Map.new()
    end)
  end

  def is_valid_a(entry) do
    case entry do
      %{"byr" => _, "iyr" => _, "ecl" => _, "eyr" => _, "hcl" => _, "hgt" => _, "pid" => _} ->
        true

      _ ->
        false
    end
  end

  def is_valid_b(entry) do
    case entry do
      %{
        "byr" => byr,
        "iyr" => iyr,
        "ecl" => ecl,
        "eyr" => eyr,
        "hcl" => hcl,
        "hgt" => hgt,
        "pid" => pid
      } ->
        year_is_valid(byr, 1920, 2002) and year_is_valid(iyr, 2010, 2020) and
          year_is_valid(eyr, 2020, 2030) and height_is_valid(hgt) and hair_color_is_valid(hcl) and
          eye_color_is_valid(ecl) and pid_is_valid(pid)

      _ ->
        false
    end
  end

  def year_is_valid(year_str, min, max) do
    year = String.to_integer(year_str)
    year >= min and year <= max
  end

  def height_is_valid(height_str) do
    [_, value_str, unit] = Regex.run(~r/^(\d+)(.*)$/, height_str)
    value = String.to_integer(value_str)

    case unit do
      "cm" -> value >= 150 and value <= 193
      "in" -> value >= 59 and value <= 76
      _ -> false
    end
  end

  def hair_color_is_valid(color) do
    Regex.match?(~r/^#[0-9a-f]{6}$/, color)
  end

  def eye_color_is_valid(color) do
    case color do
      c when c in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] -> true
      _ -> false
    end
  end

  def pid_is_valid(pid) do
    Regex.match?(~r/^[0-9]{9}$/, pid)
  end
end
