class Book

  attr_reader :title

  def initialize title = nil
    @title = titleize title if !title.nil?
  end

  def title=(new_title)
    @title = titleize new_title
  end

  private

    @@little_words = ["a", "and", "the", "in", "of", "an"]

    def titleize string
      string.split.map.with_index do |word, idx|
        if idx == 0 || !@@little_words.include?(word)
          word.capitalize
        else
          word
        end
      end.join(" ")
    end

end
