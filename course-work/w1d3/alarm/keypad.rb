class Keypad

  attr_reader :code_bank, :code_length

  def initialize(code_length, mode_keys = [1,2,3])
    @code_length = code_length
    @key_history = []
    set_code_bank
    @mode_keys = mode_keys
  end

  def set_code_bank
    @code_bank = {}
    ((0..9).to_a * @code_length).permutation(@code_length).each do |code|
      @code_bank[code] = false
    end
  end

  def press(key)
    return false unless is_valid?(key)
    if @key_history.length > @code_length
      @key_history.shift
    end
    @key_history << key
    if @mode_keys.include?(key) && @key_history.length > @code_length
      check_code_history
    end
  end

  def check_code_history
    @code_bank[@key_history[0...@code_length]] = true
  end

  def is_valid?(key)
    (0..9).to_a.include?(key)
  end

  def all_codes_entered?
    @code_bank.values.all? { |value| value }
  end

end
