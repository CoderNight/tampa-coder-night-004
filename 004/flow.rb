def flow(total_iterations, map)
  remaining_moves, lines, i = total_iterations.to_i - 1, map.split("\n"), 1
  until remaining_moves <= 0 do
    line, next_line  = lines[i], lines[i+1]
    start            = line.index('~ ') + 1 rescue break # No where to go? We're done!
    next_line_start  = next_line.index(' ')
    wall             = line.index(' #')
    stop             = [next_line_start, wall].compact.min
    moves            = stop - start + 1
    moves_allowed    = (remaining_moves - moves) >= 0 ? moves : remaining_moves
    remaining_moves -= moves_allowed
    line[start..start+(moves_allowed-1)] = '~' * moves_allowed
    if next_line_start && next_line_start < wall
      (next_line[next_line_start] = '~'; remaining_moves -= 1) if remaining_moves > 0
      i += 1
    else
      i -= 1
    end
  end
  lines.join("\n")
end

if __FILE__ == $0
  map = flow *File.read(ARGV[0]).split("\n\n")
  columns = map.split("\n").each_with_object([]) do |row, cols|
    row.each_char.with_index do |char, i|
      (cols[i] = '~'; next) if char == ' ' && cols[i] != '~' && cols[i] > 0
      char == '~' ? cols[i] = (cols[i] || 0) + 1 : cols[i] ||= 0
    end
  end
  puts map.gsub('~', "\e[34m~\e[0m").gsub('#', "\e[33m#\e[0m") + "\n\n" + columns.join(' ')
end