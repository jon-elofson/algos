class IntHashSet
  DEFAULT_SIZE = 8
  MAX_LOAD = 1.00

  attr_reader :count

  def initialize
    self.buckets = Array.new(DEFAULT_SIZE) { [] }
    self.count = 0
  end

  # O(1) randomized
  def include?(value)
    # include is linear time, but if bucket size is constant if data
    # is randomly distributed, then this is O(1) randomized.
    bucket_for(value).include?(value)
  end

  # O(1) randomized, amortized
  def insert(value)
    # This takes O(1) randomized
    return false if include?(value)

    # Resize if we would exceed max load. Is O(n), but happens
    # infrequently, so amortized O(1)
    self.resize! if (count + 1).fdiv(buckets.length) > MAX_LOAD

    # DynamicArray push is O(1) amortized
    bucket_for(value) << value
    self.count += 1

    true
  end

  # O(1) randomized
  def remove(value)
    # This takes O(1) randomized
    return unless include?(value)

    # delete is linear time, but if bucket size is constant if data
    # is randomly distributed, then this is O(1) randomized.
    bucket_for(value).delete(value)
    self.count -= 1
  end

  protected
  attr_accessor :buckets
  attr_writer :count

  def bucket_for(value, buckets = self.buckets)
    buckets[value_hash(value) % buckets.length]
  end

  def value_hash(value)
    value
  end

  def resize!
    new_buckets = Array.new(buckets.length * 2) { [] }
    # Takes O(n) time despite double loops.
    buckets.each do |bucket|
      bucket.each do |item|
        bucket_for(item, new_buckets) << item
      end
    end

    self.buckets = new_buckets
  end
end
