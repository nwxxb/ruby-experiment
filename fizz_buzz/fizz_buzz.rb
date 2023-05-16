require 'optparse'

class FizzBuzz
  def self.start(args)
    options = {}
    parser = OptionParser.new do |parser|
      parser.banner = "Usage: #{parser.program_name} [options] limit"
      parser.on("-f", "--fizz NUMBER", Integer, "Positive NUMBER as divider for fizz") do |number|
        options[:fizz_divider] = number
      end
      parser.on("-b", "--buzz NUMBER", Integer, "Positive NUMBER as divider for buzz") do |number|
        options[:buzz_divider] = number
      end
    end

    begin
      parser.parse!(args)
      options[:until] = args.pop.to_i

      if options[:fizz_divider].nil?
        raise OptionParser::MissingArgument, '--fizz'
      elsif options[:buzz_divider].nil?
        raise OptionParser::MissingArgument, '--buzz'
      elsif options[:until].nil? || options[:until] == 0
        raise OptionParser::MissingArgument, 'limit number not provided'
      end

      puts new(options[:fizz_divider], options[:buzz_divider]).count(options[:until])
    rescue => e
      puts e
      puts parser
    end
  end

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
