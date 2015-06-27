class Player

  attr_reader :name, :ghost_counter

  def initialize(name)
    @name = name
    @ghost_counter = ""
    @ghost_mode = false
  end

  def increment_ghost_counter
    @ghost_counter << "GHOST"[@ghost_counter.length]
  end

  def tell_ghost_mode
    @ghost_mode = true
  end

end

class HumanPlayer < Player

  def get_input
    puts "Enter a letter please, #{@name}"
    input = gets.chomp
    if input.length == 1
      letter = input
    else
      puts "Too many letters"
      get_input
    end
    front = @ghost_mode ? in_front? : false
    [letter, front]
  end

  def in_front?
    puts "Front or back?(f/b)"
    input = gets.chomp
    if ['f', 'b'].include?(input)
      input == 'f'
    else
      puts "Incorrect input"
      in_front?
    end
  end

  def get_fragment(fragment)
  end

  def get_player_count(count)
  end

end

class AiPlayer < Player

  def initialize(name)
    @name = name
    @ghost_counter = ""
    @ghost_mode = false
    @super_mode = true
    setup_dictionary
  end

  def setup_dictionary
    @dictionary = Set.new
    File.readlines('dictionary.txt').each do |word|
      @dictionary << word.chomp
    end
  end

  def get_fragment(fragment)
    @current_fragment = fragment
    if fragment == ""
      setup_dictionary
    else
      update_dictionary
    end
  end


  def update_dictionary
    @dictionary.select! {|word| word.include?(@current_fragment)}
  end

  # def start_is?(word, start)
  #   word[0...start.length] == start
  # end


  def get_input
    letter_hash = {}
    ("a".."z").each do |letter|
      letter_hash[[letter,false,false]] = win_proportion(@current_fragment + letter)
    end
    if @ghost_mode
      ("a".."z").each do |letter|
        letter_hash[[letter,true,false]] = win_proportion(letter + @current_fragment)
      end
    end
    if @super_mode
      ("a".."z").each do |letter|
        letter_hash[[letter,false,true]] = win_proportion(@current_fragment.reverse + letter) + 0.1
      end
      if @ghost_mode
        ("a".."z").each do |letter|
          letter_hash[[letter,true,true]] = win_proportion(letter + @current_fragment.reverse) + 0.1
        end
      end
    end
    min_proportion = letter_hash.values.max - 0.1
    letter_hash.select do |letter, prop|
      prop >= min_proportion
    end.keys.sample
  end

  def win_proportion(fragment)
    return 0 if @dictionary.include?(fragment)
    words = @dictionary.select {|word| word.include?(fragment) || word.include?(fragment.reverse) }
    return -1 if words.empty?
    good_words = words.select do |word|
      (word.length - fragment.length) % @player_count != 0
    end
    good_words.length.to_f / words.length
  end

  def get_player_count(count)
    @player_count = count
  end


end
