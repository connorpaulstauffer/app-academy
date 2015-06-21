
# Let's write a class named MyHashSet that will implement some of the
# functionality of a set. Our MyHashSet class will utilize a Ruby hash to keep
# track of which elements are in the set.
class MyHashSet

  def initialize
    @store = {}
  end

  def insert el
    @store[el] = true
  end

  def include? el
    @store.has_key? el
  end

  def delete el
    return false unless self.include? el
    store.delete el
    true
  end

  def union set
    hash = MyHashSet.new
    [self, set].each{ |set| set.store.keys.each{ |key| hash.insert key } }
    hash
  end

  def intersect set
    intersection = MyHashSet.new
    self.store.keys.each{ |key| intersection.insert key if set.include? key }
    intersection
  end

  def minus set
    hash = MyHashSet.new
    self.store.keys.each{ |key| hash.insert(key) unless set.include? key }
    hash
  end

  protected

    attr_reader :store

end
