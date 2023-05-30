require 'optparse'
require 'pry'

class TicTacToe
  def self.cli_start(args)
    board_data = Array.new(3) { Array.new(3, ' ') }
    puts( 
      "+-+-+-+\n" + board_data.map do |row|
        "|#{row.join('|')}|\n"
      end.join("+-+-+-+\n") + "+-+-+-+\n"
    )

    options = {first_player: 'O', second_player: 'X'}
    OptionParser.new do |opts|
      opts.on("-fSYMBOL", "--first=SYMBOL", String, "Symbol for the first player") do |symbol|
        options[:first_player] = symbol
      end
      opts.on("-sSYMBOL", "--second=SYMBOL", String, "Symbol for the second player") do |symbol|
        options[:second_player] = symbol
      end
    end.parse!(args)

    count = 1
    loop do
      win_conditions = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9],
        [1, 5, 9],
        [3, 5, 7],
      ]

      winner = nil
      win_conditions.each do |positions|
        str_result = positions.reduce('') do |result, position|
          current_row, current_col = case position
                     when 1 then [0, 0]
                     when 2 then [0, 1]
                     when 3 then [0, 2]
                     when 4 then [1, 0]
                     when 5 then [1, 1]
                     when 6 then [1, 2]
                     when 7 then [2, 0]
                     when 8 then [2, 1]
                     when 9 then [2, 2]
                     end
          result += board_data[current_row][current_col]
        end

        if str_result == (options[:first_player] * 3)
          winner = options[:first_player]
          break
        elsif str_result == (options[:second_player] * 3)
          winner = options[:second_player]
          break
        end
      end

      if winner
        puts "#{winner} Win!"
        break
      end

      current_symbol = count.odd? ? options[:first_player] : options[:second_player]
      step = $stdin.gets
      row, col = case step.to_i
                 when 1 then [0, 0]
                 when 2 then [0, 1]
                 when 3 then [0, 2]
                 when 4 then [1, 0]
                 when 5 then [1, 1]
                 when 6 then [1, 2]
                 when 7 then [2, 0]
                 when 8 then [2, 1]
                 when 9 then [2, 2]
                 end

      if step.to_i.between?(1, 9) && board_data[row][col] == ' '
        board_data[row][col] = current_symbol
        count = count + 1
        puts( 
          "+-+-+-+\n" + board_data.map do |row|
            "|#{row.join('|')}|\n"
          end.join("+-+-+-+\n") + "+-+-+-+\n"
        )
      else
        puts "invalid input or can't take filled cell"
        break
      end
    end

  end
end
