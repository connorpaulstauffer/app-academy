
class Dictionary

  attr_reader :entries

  def initialize
    @entries = {}
  end

  def keywords
    @entries.keys.sort
  end

  def printable
    keywords.map { |word| "[#{word}] \"#{@entries[word]}\"" }.join("\n")
  end

  def add(value)
    value.class == Hash ? @entries.merge!(value) : @entries[value] = nil
  end

  def include?(word)
    keywords.include?(word)
  end

  def find(prefix)
    @entries.select { |word, _| word.slice(0, prefix.length) == prefix }
  end

end
