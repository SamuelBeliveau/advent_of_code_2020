defmodule AOC.Day8 do
  def solve_a() do
    instructions = read_instructions()
    follow_instruction(instructions, [], 0, 0)
  end

  def follow_instruction(instructions, visited, index, accumulator) do
    if Enum.member?(visited, index) do
      IO.puts("This is the end...")
      accumulator
    else
      visited = [index | visited]
      {instr, value} = instructions |> Enum.at(index)

      case instr do
        "jmp" -> follow_instruction(instructions, visited, index + value, accumulator)
        "acc" -> follow_instruction(instructions, visited, index + 1, accumulator + value)
        "nop" -> follow_instruction(instructions, visited, index + 1, accumulator)
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
