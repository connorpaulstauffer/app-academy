require 'set'
require_relative "keypad"
require 'byebug'

class KeypadTester

  def initialize(code_length, mode_keys = [1, 2, 3])
    @keypad = Keypad.new(code_length, mode_keys)
    @presses = 0
    @previous_entries = []
    @code_length = code_length
    set_code_bank
  end

  def set_code_bank
    @code_bank = Set.new
    ((0..9).to_a * @code_length).permutation(@code_length).each do |code|
      @code_bank << code
    end
  end

  def run
    until @keypad.all_codes_entered?
      entry = choose_entry
      @keypad.press(entry)
      add_previous_entry(entry)
      @presses += 1
      puts @code_bank.length
    end
    puts @presses
  end


  def add_previous_entry(entry)
    if @previous_entries.length >= @code_length
      @previous_entries.shift
    end
    @previous_entries << entry
  end

  def choose_entry
    if @previous_entries.length < @code_length
      return 0
    elsif @code_bank.include?(@previous_entries)
      update_code_bank
      return first_mode_key
    else
      return first_any_key(@code_length)
    end
  end

  def first_mode_key
    @code_bank.each do |code|
      if code[0...@code_length] == @previous_entries[1..@code_length]
        if code.last == 2 || code.last == 3
          return code.last
        end
      end
    end
    1
  end

  def first_any_key(length)
    return @code_bank.first.first if length == 0
    @code_bank.each do |code|
      start_of_code = code[0...(length - 1)]
      end_of_entries = @previous_entries[(@code_length - length + 1)..@code_length]
      if start_of_code == end_of_entries
        return code[length - 1]
      end
    end
    return first_any_key(length - 1)
  end

  def update_code_bank
    previous_entries = @previous_entries.dup
    @code_bank.delete(previous_entries)
  end

end

tester = KeypadTester.new(4)
tester.run
