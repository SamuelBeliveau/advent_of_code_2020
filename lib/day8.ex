defmodule AOC.Day8 do
  def solve_a() do
    instructions = read_instructions()
    follow_instruction(instructions, [], 0, 0)
  end

  def solve_b() do
    instructions = read_instructions()
    problematic_indexes = get_problematic_indexes(instructions)

    0..(length(problematic_indexes) - 1)
    |> Enum.each(fn index ->
      instructions_variation = generate_variation(instructions, problematic_indexes, index)
      follow_instruction(instructions_variation, [], 0, 0)
    end)
  end

  def get_problematic_indexes(instructions) do
    instructions
    |> Enum.with_index()
    |> Enum.filter(fn {{instr, _}, _} -> instr == "jmp" or instr == "nop" end)
    |> Enum.map(fn {_, index} -> index end)
  end

  def generate_variation(instructions, problematic_indexes, variation_index) do
    indexed_instructions = instructions |> Enum.with_index()

    instruction_index =
      problematic_indexes
      |> Enum.at(variation_index)

    indexed_instructions
    |> Enum.map(fn {{instr, value}, index} ->
      if index != instruction_index do
        {instr, value}
      else
        case instr do
          "jmp" -> {"nop", value}
          "nop" -> {"jmp", value}
        end
      end
    end)
  end

  def follow_instruction(instructions, visited, index, accumulator) do
    if Enum.member?(visited, index) do
      IO.puts("This is the end...")
      accumulator
    else
      visited = [index | visited]

      case instructions |> Enum.at(index) do
        {instr, value} ->
          case instr do
            "jmp" -> follow_instruction(instructions, visited, index + value, accumulator)
            "acc" -> follow_instruction(instructions, visited, index + 1, accumulator + value)
            "nop" -> follow_instruction(instructions, visited, index + 1, accumulator)
          end

        nil ->
          IO.puts(
            "Exited! index = #{index} vs len = #{length(instructions)}, acc = #{accumulator}"
          )

          accumulator
      end
    end
  end

  def read_instructions do
    lines = AOC.Utilities.read_lines("inputs/day8.txt")
    lines |> Enum.map(&parse_instruction/1)
  end

  def parse_instruction(line) do
    [_, instr, value] = Regex.run(~r/([a-z]*) ([+|-]\d+)/, line)
    {instr, String.to_integer(value)}
  end
end
