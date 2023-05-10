require 'minitest/autorun'
require 'minitest/rg'
require_relative './fizz_buzz'

class FizzBuzzTest < Minitest::Test
  def test_translate_a_number_to_fizz
    assert_equal 'fizz', FizzBuzz.new(3, 5).translate(3)
  end

  def test_translate_another_number_to_fizz
    assert_equal 'fizz', FizzBuzz.new(3, 5).translate(6)
  end

  def test_translate_a_number_to_buzz
    assert_equal 'buzz', FizzBuzz.new(3, 5).translate(10)
  end

  def test_translate_another_number_to_buzz
    assert_equal 'buzz', FizzBuzz.new(3, 5).translate(20)
  end

  def test_translate_a_number_to_fizz_buzz
    assert_equal 'fizzbuzz', FizzBuzz.new(3, 5).translate(30)
  end

  def test_translate_a_number_to_fizz_buzz
    assert_equal 'fizzbuzz', FizzBuzz.new(3, 5).translate(15)
  end

  def test_no_translate
    assert_equal 1, FizzBuzz.new(3, 5).translate(1)
  end

  def test_another_no_translate
    assert_equal 4, FizzBuzz.new(3, 5).translate(4)
  end

  def test_count
    expected_result = "1, 2, fizz, 4, 5, fizzbuzz, 7, 8, fizz, 10, 11, fizzbuzz"
    assert_equal expected_result, FizzBuzz.new(3, 6).count(12)
  end
end
