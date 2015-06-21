
class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end


end


class HumanPlayer < Player

  def initialize(name)
    super(name)
  end

  def choose_word
    print "\nHow many characters does your word have? "
    "_" * gets.chomp.to_i
  end

  def guess
    print "\nEnter your guess as a single character or an entire word: "
    gets.chomp.downcase
  end

  def check_guess(guess)
    print "\nEnter the indexes of your word containing the guessed letter(seperate by commas): "
    gets.chomp.gsub(" ", "").split(",").map(&:to_i)
  end

  def handle_guess_response(response)
    nil
  end

  def word
    print "\nWhat was the target word? "
    gets.chomp
  end

end


class ComputerPlayer < Player

  attr_reader :word

  def initialize(name)
    super(name)
    @dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @guesses = []
  end

  def choose_word
    @word = @dictionary.sample
    "_" * @word.length
  end

  def get_target_length(length)
    filter_by_length(length)
  end

  def guess
    if @dictionary.length == 1
      puts "\n#{name} guesses '#{@dictionary.first}'"
      return @dictionary.first
    end
    @guesses << most_common_letter
    puts "\n#{name} guesses '#{@guesses.last}'"
    @guesses.last
  end

  def check_guess(guess)
    if guess.length > 1
      return (0...@word.length).to_a if guess == @word
      []
    else
      (0...@word.length).to_a.select { |idx| @word[idx] == guess }
    end
  end

  def handle_guess_response(response)
      filter_by_indexes(response)
  end

  def most_common_letter
    letters = @dictionary.join("").chars
    unique_letters = not_guessed(letters.uniq)
    unique_letters.sort_by { |letter| letters.count(letter) }.last
  end

  def filter_by_length(length)
    @dictionary.select! { |word| word.length == length }
  end

  def filter_by_indexes(indexes)
    @dictionary.select! { |word| indexes_match?(word, indexes) }
  end

  def indexes_match?(word, indexes)
    word_indexes = (0...word.length).to_a.select do |idx|
                     word[idx] == @guesses.last
                   end
    word_indexes.sort == indexes.sort
  end

  def not_guessed(letters)
    letters.select { |letter| !@guesses.include?(letter) }
  end

end
