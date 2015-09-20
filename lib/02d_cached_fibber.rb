require_relative "02c_lru_cache"

class UncachedFibber
  attr_reader :calculations

  def initialize
    self.calculations = 0
  end

  def calculate(n)
    self.calculations += 1

    return 0 if n == 0
    return 1 if n == 1
    return calculate(n - 2) + calculate(n - 1)
  end

  protected
  attr_writer :calculations
end

class CachedFibber
  attr_reader :cache

  def initialize(max_size)
    self.cache = LRUCache.new(max_size) do |n|
      calculate(n, false)
    end
  end

  def calculate(n, use_cache = true)
    if use_cache
      return cache[n]
    end

    return 0 if n == 0
    return 1 if n == 1
    return self.calculate(n - 2) + self.calculate(n - 1)
  end

  protected
  attr_writer :cache
end

def main
  uncached_fibber = UncachedFibber.new
  puts "Start of UncachedFibber: #{Time.now}"
  puts uncached_fibber.calculate(35)
  puts "End of UncachedFibber: #{Time.now}"
  puts "Number of calculations: #{uncached_fibber.calculations}"

  # Just a little cache can help a lot!
  cached_fibber = CachedFibber.new(10)
  puts "Start of CachedFibber: #{Time.now}"
  puts cached_fibber.calculate(35)
  puts "End of CachedFibber: #{Time.now}"
  puts "Cache hits: #{cached_fibber.cache.hits}"
  puts "Cache misses: #{cached_fibber.cache.misses}"
end

if $PROGRAM_NAME == __FILE__
  main
end
