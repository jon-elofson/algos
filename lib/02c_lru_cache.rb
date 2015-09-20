require_relative "02b_linked_list"

class LRUCache
  attr_reader :hits, :misses

  def initialize(max_size, &prc)
    @links_hash, @linked_list, @max_size, @prc =
      {}, LinkedList.new, max_size, prc

    # Logging
    self.hits, self.misses = 0, 0
  end

  def [](key)
    if @links_hash.has_key?(key)
      link = @links_hash[key]
      link.remove
      @linked_list.push_link(link)

      # Logging
      self.hits += 1

      return link.value
    end

    # Logging
    self.misses += 1

    if @links_hash.count == @max_size
      link = @linked_list.shift_link
      @links_hash.delete(link.value)
    end

    value = @prc.call(key)
    @links_hash[key] = @linked_list.push(value)

    value
  end

  protected
  attr_writer :hits, :misses
end
