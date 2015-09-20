class MaxIntSet
  attr_reader :count

  # Uses memory proportional to size of max value, not the number of
  # elements.
  def initialize(max_value)
    self.count, self.store = 0, Array.new(max_value, false)
  end

  # O(1)
  def include?(value)
    store[value]
  end

  # O(1)
  def insert(value)
    return false if include?(value)

    store[value] = true
    self.count += 1

    true
  end

  # O(1)
  def remove(value)
    return false unless include?(value)

    store[value] = false
    self.count -= 1

    true
  end

  protected
  attr_accessor :store
  attr_writer :count
end
