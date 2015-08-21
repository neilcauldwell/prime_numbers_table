class PrimeTable
	require 'optparse'
  require 'terminal-table'

  def self.generate_table(total)
    prime_numbers = generate_prime_numbers(total)
    headings = prime_numbers.clone.unshift("")

    table = Terminal::Table.new :headings => headings do |t|
      t.style = {:border_i => "-"}

      prime_numbers.length.times do |x|
        row = [prime_numbers[x]]
        prime_numbers.length.times do |y|
          row << prime_numbers[x] * prime_numbers[y]
        end
        t << row
      end
    end

    puts table
  end

  def self.generate_prime_numbers(amount = 10)
    prime_numbers = []
    prime_index = 0

    until prime_numbers.length == amount
      prime_index = next_prime(prime_index)
      prime_numbers << prime_index
    end
    return prime_numbers
  end

  def self.next_prime(n)
    prime_number = n + 1

    until is_prime? prime_number do
      prime_number += 1
    end
    return prime_number
  end

  def self.is_prime?(n)
    return false if n <= 1

    (2..Math::sqrt(n)).each do |x|
      return false if n % x == 0
    end
    return true
  end

  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: prime_table.rb [options]"
    opts.on('-n', '--count AMOUNT', 'Number of prime numbers') { |v|
      PrimeTable.generate_table(v.to_i)
    }
  end.parse!
end