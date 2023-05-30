require 'optparse'

class TicTacToe
  def self.cli_start(args)
    board_data = Array.new(3) { Array.new(3, ' ') }
    puts <<~BOARD
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    options = {first_player: 'O', second_player: 'X'}
    OptionParser.new do |opts|
      opts.on("-fSYMBOL", "--first=SYMBOL", String, "Symbol for the first player") do |symbol|
        options[:first_player] = symbol
      end
      opts.on("-sSYMBOL", "--second=SYMBOL", String, "Symbol for the second player") do |symbol|
        options[:second_player] = symbol
      end
    end.parse!(args)

    loop do
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

      if step.to_i.between? 1, 9
        board_data[row][col] = options[:first_player]
        puts( 
          "+-+-+-+\n" + board_data.map do |row|
            "|#{row.join('|')}|\n"
          end.join("+-+-+-+\n") + "+-+-+-+\n"
        )
      else
        puts 'input empty'
        break
      end
    end

  end
end
