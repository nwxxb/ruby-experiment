class FizzBuzz
  def initialize(fizz_divider, buzz_divider)
    @fizz_divider = fizz_divider
    @buzz_divider = buzz_divider
  end

  def count(limit)
    (1..limit).map do |number|
      translate(number)
    end.join(', ')
  end

  def translate(number)
    if ((number % @fizz_divider) == 0) && ((number % @buzz_divider) == 0)
      'fizzbuzz'
    elsif ((number % @fizz_divider) == 0)
      'fizz'
    elsif ((number % @buzz_divider) == 0)
      'buzz'
    else
      number
    end
  end
end
