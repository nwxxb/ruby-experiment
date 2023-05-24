require 'minitest/autorun'
require_relative '../lib/tic_tac_toe'
require 'pry'

class TicTacToeTest < Minitest::Test
  def test_render_board
    ttt = TicTacToe.new(first_player: 'X', second_player: 'O')
    expected_board = <<~BOARD
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    assert_equal expected_board, ttt.render
  end

  def test_first_move
    ttt = TicTacToe.new(first_player: 'X', second_player: 'O')
    ttt.move(1)
    expected_board = <<~BOARD
      +-+-+-+
      |X| | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    assert_nil ttt.find_winner
    assert_equal expected_board, ttt.render
  end

  def test_another_first_move
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)
    expected_board = <<~BOARD
      +-+-+-+
      |O| | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    assert_equal expected_board, ttt.render
  end

  def test_second_move
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)
    ttt.move(2)
    expected_board = <<~BOARD
      +-+-+-+
      |O|X| |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    assert_equal expected_board, ttt.render
  end

  def test_another_second_move
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)
    ttt.move(9)
    expected_board = <<~BOARD
      +-+-+-+
      |O| | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | |X|
      +-+-+-+
    BOARD

    assert_equal expected_board, ttt.render
  end

  def test_third_move
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)
    ttt.move(9)
    ttt.move(7)
    expected_board = <<~BOARD
      +-+-+-+
      |O| | |
      +-+-+-+
      | | | |
      +-+-+-+
      |O| |X|
      +-+-+-+
    BOARD

    assert_nil ttt.find_winner
    assert_equal expected_board, ttt.render
  end

  def test_cannot_reuse_position
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)
    ttt.move(2)

    assert_raises(TicTacToe::CannotReusePosition) { ttt.move(1) }
  end

  def test_opponent_cannot_reuse_position
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)

    assert_raises(TicTacToe::CannotReusePosition) { ttt.move(1) }
  end

  def test_horizontally_win_condition
    ttt = TicTacToe.new(first_player: 'O', second_player: 'X')
    ttt.move(1)
    ttt.move(9)
    ttt.move(2)
    ttt.move(5)
    ttt.move(3)
    # +-+-+-+
    # |O|O|O|
    # +-+-+-+
    # | |X| |
    # +-+-+-+
    # | | |X|
    # +-+-+-+

    assert_equal 'O', ttt.find_winner
  end

  def test_another_horizontally_win_condition
    ttt = TicTacToe.new(first_player: 'X', second_player: 'O')
    ttt.move(4)
    ttt.move(9)
    ttt.move(5)
    ttt.move(7)
    ttt.move(6)
    # +-+-+-+
    # | | | |
    # +-+-+-+
    # |O|O|O|
    # +-+-+-+
    # |X| |X|
    # +-+-+-+

    assert_equal 'X', ttt.find_winner
  end
end
