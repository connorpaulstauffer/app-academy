require 'set'

class WordChainer

  def initialize(dictionary_file)
    @dictionary = Set.new File.readlines(dictionary_file).map(&:chomp)
  end

  def adjacent_words(word)
    adjacent_strings(word).select { |string| @dictionary.include?(string) }
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }
    until @current_words.empty?
      explore_current_words(target)
      break if @all_seen_words.keys.include?(target)
    end
    return nil unless @all_seen_words.keys.include?(target)
    build_path(target)
  end

  def build_path(target)
    parent = @all_seen_words[target]
    return [target] if parent.nil?
    build_path(parent) + [target]
  end

  private

    def explore_current_words(target)
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words(current_word).each do |adj_word|
          unless @all_seen_words.include?(adj_word)
            new_current_words << adj_word
            @all_seen_words[adj_word] = current_word
          end
          if adj_word == target
            print_words_and_parents(new_current_words)
            return @current_words = new_current_words
          end
        end
      end
      print_words_and_parents(new_current_words)
      @current_words = new_current_words
    end

    def print_words_and_parents(words)
      words.each do |word|
        puts "#{word}: #{@all_seen_words[word]}"
      end
    end

    def adjacent_strings(string)
      adjacent = []
      string.length.times do |idx|
        ('a'..'z').each do |new_char|
          new_string = string.dup
          new_string[idx] = new_char
          adjacent << new_string unless new_string == string
        end
      end
      adjacent
    end

end
