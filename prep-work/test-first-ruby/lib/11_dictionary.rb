class Dictionary

  attr_reader :entries

  def initialize
    @entries = Hash.new(nil)
  end

  def add entry
    entry.is_a?(Hash) ? @entries.merge!(entry) : @entries[entry] = nil
  end

  def keywords
    @entries.keys.sort
  end

  def include? key
    @entries.keys.include?(key)
  end

  def find key
    @entries.select { |k, v| k[0..(key.length - 1)] == key }
  end

  def printable
    @entries.sort.map { |key, val| "[#{key}] \"#{val}\""}.join("\n")
  end

end
