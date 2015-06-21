
class GuessingGame

  def initialize
    @correct_answer = rand(100) + 1
    @number_of_guesses = 0
  end

  def play
    begin
      puts "Too #{high_or_low}" unless @most_recent_guess.nil?
      get_guess
    end until guessed_correctly?

    "#{@most_recent_guess} is right! You took #{@number_of_guesses} guesses."
  end

  private

    def get_guess
      print "Pick a number from 1-100: "
      @most_recent_guess = gets.chomp.to_i
      @number_of_guesses += 1
    end

    def high_or_low
      @most_recent_guess > @correct_answer ? "high" : "low"
    end

    def guessed_correctly?
      @most_recent_guess == @correct_answer
    end

end

class File

  def shuffle_file
    open(shuffleize_file_name, "w") do |file|
      get_shuffled_lines.each { |line| file.print line }
    end
    nil
  end

  private

    def shuffleize_file_name
      path.gsub(/\./, "-shuffle\\0")
    end

    def get_shuffled_lines
      readlines.shuffle
    end

end

class TestClass

  @@operator_hash = { plus: :+ }

  def method_missing(sym)
    @@operator_hash[sym]
  end

end
