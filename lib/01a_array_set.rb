class ArraySet
  attr_reader :count

  def initialize
    self.count, self.store = 0, []
  end

  # O(n)
  def include?(target_item)
    # Using each to emphasize O(n) time complexity.
    store.each do |item|
      return true if item == target_item
    end

    false
  end

  # O(n)
  def insert(item)
    return false if include?(item)

    store << item
    self.count += 1
    # return true if item is added
    true
  end

  # O(n)
  def remove(target_item)
    # again iterating to emphasize O(n) time complexity.
    store.each_with_index do |item, idx|
      next unless item == target_item

      store.delete_at(idx)
      self.count -= 1
      return true
    end

    false
  end

  protected
  attr_accessor :store
  attr_writer :count
end
