load 'player.rb'

class HangManGame

  def initialize
    @number_of_turns = 0
    setup
    play
  end

  def setup
    print "\nGuessing Player, computer or human?(type 'c' or 'h' and press enter): "
    loop do
      type = gets.chomp
      if type == 'c' || type == 'h'
        print "\nEnter a name for Guessing Player: "
        name = gets.chomp
        @guessing_player = (type == 'c') ? ComputerPlayer.new(name) : HumanPlayer.new(name)
        break
      end
      print "\nEnter 'c' or 'h' and press enter: "
    end

    print "\nChecking Player, computer or human?(type 'c' or 'h' and press enter): "
    loop do
      type = gets.chomp
      if type == 'c' || type == 'h'
        print "\nEnter a name for Checking Player: "
        name = gets.chomp
        @checking_player = (type == 'c') ? ComputerPlayer.new(name) : HumanPlayer.new(name)
        break
      end
      print "\nEnter 'c' or 'h' and press enter: "
    end

    print "\n#{@checking_player.name}, how many guesses are allowed? "
    @max_turns = gets.chomp.to_i
  end

  def play
    set_response_string
    until over?
      display_response_string
      execute_turn
    end
    output_result
  end

  def set_response_string
    @response_string = @checking_player.choose_word
    if @guessing_player.class == ComputerPlayer
      @guessing_player.get_target_length(@response_string.length)
    end
  end

  def execute_turn
    guess = @guessing_player.guess
    guess_response = @checking_player.check_guess(guess)
    @guessing_player.handle_guess_response(guess_response)
    update_response_string(guess, guess_response)
    @number_of_turns += 1
  end

  def update_response_string(guess, guess_response)
    if guess_response == (0...@response_string.length).to_a
      @response_string = guess
    else
      guess_response.each { |idx| @response_string[idx] = guess }
    end
  end

  def over?
    guessed_correctly? || too_many_turns?
  end

  def guessed_correctly?
    !@response_string.include?("_")
  end

  def too_many_turns?
    @number_of_turns > @max_turns
  end

  def display_response_string
    puts "\n#{@response_string}"
  end

  def output_result
    if guessed_correctly?
      puts "\n#{@guessing_player.name} guessed correctly! "
    else
      puts "\n#{@guessing_player.name} took too many guesses. "
    end
    puts "The word is #{get_word}."
  end

  def get_word
    return @response_string if guessed_correctly?
    @checking_player.word
  end

end

HangManGame.new
