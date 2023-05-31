require 'minitest/autorun'
require 'pry'
require 'stringio'
require_relative '../lib/tic_tac_toe'

# TicTacToe.cli_start(ARGV)

class IoTestHelpers
  def self.simulate_io(*inputs, &block)
    #    0           1            2
    orig_stdin, orig_stdout, orig_stderr = $stdin, $stdout, $stderr
    $stdin, $stdout, $stderr = StringIO.new, StringIO.new, StringIO.new

    inputs.flatten.each do |input|
      $stdin.puts input
    end

    $stdin.rewind
    yield
    return $stdout.string, $stderr.string
  ensure
    $stdin, $stdout, $stderr = orig_stdin, orig_stdout, orig_stderr
  end
end

class TicTacToeTest < Minitest::Test
  def test_render_empty_board_when_starting
    expected_board = <<~BOARD
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io() do
      args = ["--first=O", "-s", "X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_first_move
    expected_board = <<~BOARD
      +-+-+-+
      |O| | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(1) do
      args = ["--first=O", "-s", "X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_another_first_move
    expected_board = <<~BOARD
      +-+-+-+
      |X| | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(1) do
      args = ["-f", "X", "--second=O"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_another_first_move
    expected_board = <<~BOARD
      +-+-+-+
      | | | |
      +-+-+-+
      | | | |
      +-+-+-+
      | | |X|
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(9) do
      args = ["-f", "X", "--second=O"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_yet_another_first_move
    expected_board = <<~BOARD
      +-+-+-+
      | | | |
      +-+-+-+
      | |O| |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(5) do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_second_move
    expected_board = <<~BOARD
      +-+-+-+
      |X| | |
      +-+-+-+
      | |O| |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(5, 1) do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_another_second_move
    expected_board = <<~BOARD
      +-+-+-+
      | | |X|
      +-+-+-+
      | |O| |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(5, 3) do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_third_move
    expected_board = <<~BOARD
      +-+-+-+
      |O| |X|
      +-+-+-+
      | |O| |
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(5, 3, 1) do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, expected_board)
  end

  def test_cannot_take_same_position
    out, err = IoTestHelpers.simulate_io(5, 3, 3) do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, "can't take filled cell")
  end

  def test_invalid_input
    out, err = IoTestHelpers.simulate_io(5, 3, 'aflj') do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, "invalid input")
  end

  def test_get_winner
    unexpected_board = <<~BOARD
      +-+-+-+
      |X|X|X|
      +-+-+-+
      |O|O|O|
      +-+-+-+
      | | | |
      +-+-+-+
    BOARD

    out, err = IoTestHelpers.simulate_io(4, 1, 5, 2, 6, 7) do
      args = ["-f", "O", "--second=X"]
      TicTacToe.cli_start(args)
    end

    assert_includes(out, "O Win!")
    refute_includes(out, unexpected_board)
  end
end
