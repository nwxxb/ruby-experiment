require 'optparse'

class TicTacToe
  def self.cli_start(args)
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

    step = $stdin.gets
    if step.to_i == 1
      x = options[:first_player]
      puts <<~BOARD
        +-+-+-+
        |#{x}| | |
        +-+-+-+
        | | | |
        +-+-+-+
        | | | |
        +-+-+-+
      BOARD
    else
      puts <<~BOARD
        +-+-+-+
        | | | |
        +-+-+-+
        | | | |
        +-+-+-+
        | | | |
        +-+-+-+
      BOARD
    end

  end
end
