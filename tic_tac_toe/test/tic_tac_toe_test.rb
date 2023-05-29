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

    assert out.include?(expected_board)
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

    assert out.include?(expected_board)
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

    assert out.include?(expected_board)
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

    out, err = IoTestHelpers.simulate_io(1) do
      args = ["-f", "X", "--second=O"]
      TicTacToe.cli_start(args)
    end

    assert out.include?(expected_board)
  end
end
