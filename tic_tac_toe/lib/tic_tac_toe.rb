class TicTacToe
  # setup first_player & second_player
  # decide which turn 
  # decide position
  # decide rendering
  # decide rule (can't overwrite, etc)
  # decide who is the winner
  # implicit knowledge
  # - use kinda ternary to map position
  # - use odd and even number to decide which player's turn
  
  class CannotReusePosition < StandardError
  end
  
  def initialize(first_player:, second_player:)
    @raw_board = Array.new(3) { Array.new(3, nil) }
    @first_player = first_player
    @second_player = second_player
    @turn = 1
  end

  def move(position)
    actual_position = case position
                      when 1
                        [0, 0]
                      when 2
                        [0, 1]
                      when 3
                        [0, 2]
                      when 4
                        [1, 0]
                      when 5
                        [1, 1]
                      when 6
                        [1, 2]
                      when 7
                        [2, 0]
                      when 8
                        [2, 1]
                      when 9
                        [2, 2]
                      end

    unless get_symbol(position).nil?
      raise CannotReusePosition
    end

    if @turn.odd?
      set_symbol(position, @first_player)
    elsif @turn.even?
      set_symbol(position, @second_player)
    end

    @turn += 1
  end

  def find_winner
    win_positions = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]
    
    win_positions.each do |win_position|
      judge_arr = win_position.map do |position|
        get_symbol(position)
      end.compact.uniq

      if judge_arr.length == 1 && judge_arr.first == @first_player
        return @first_player
      elsif judge_arr.length == 1 && judge_arr.first == @second_player
        return @second_player
      else
        next
      end
    end
  end

  def get_actual_position(position)
    case position
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
  end
  
  def set_symbol(position, value)
    actual_position = get_actual_position(position)
    @raw_board[actual_position[0]][actual_position[1]] = value
  end

  def get_symbol(position)
    @raw_board.dig(*get_actual_position(position))
  end

  def render
    test = @raw_board.map do |row|
      "|#{row.map{|val| val.nil? ? ' ' : val}.join('|')}|\n"
    end
    return "+-+-+-+\n#{test.join("+-+-+-+\n")}+-+-+-+\n"
  end
end
