require_relative "02a_link"

# A SentinelLink class helps us manage a list. A linked list will
# always include at least two links: the first and last
# sentinels. They're dummy objects.
class SentinelLink < Link
  def initialize(side)
    raise "incorrect side choice" unless [:first, :last].include?(side)
    self.side = side
  end

  def prev=(link)
    if side == :last
      return super(link)
    elsif link.nil?
      # the first sentinel may allow superfluous set of prev to `nil`.
    else
      raise "can't set prev of first sentinel"
    end
  end

  def next=(link)
    if side == :first
      return super(link)
    elsif link.nil?
      # the last sentinel may allow superfluous set of next to `nil`.
    else
      raise "can't set next of last sentinel"
    end
  end

  def value
    raise "Sentinels don't have values!"
  end

  def value=(link)
    raise "Sentinels don't have values!"
  end

  def remove
    raise "Can't remove a sentinel!"
  end

  protected
  attr_accessor :side
end

class LinkedList
  def initialize
    self.first = SentinelLink.new(:first)
    self.last = SentinelLink.new(:last)

    self.first.insert_right(self.last)
  end

  # O(n): don't use me!
  def [](idx)
    raise "index out of bounds" if idx < 0

    link = first
    (idx + 1).times do
      link = link.next

      # We overran the list if we ever hit the sentinel.
      raise "index out of bounds" if link == last
    end

    link
  end

  def empty?
    # Nothing between the sentinels
    first.next == last
  end

  def pop
    pop_link.value
  end

  def pop_link
    raise "can't pop from empty list!" if empty?

    link = last.prev
    link.remove
    link
  end

  def push(value)
    push_link(Link.new(value))
  end

  def push_link(link)
    last.insert_left(link)
    link
  end

  def shift
    shift_link.value
  end

  def shift_link
    raise "can't pop from empty list!" if empty?

    link = first.next
    link.remove
    link
  end

  def unshift(value)
    unshift_link(Link.new(value))
  end

  def unshift_link(link)
    first.insert_right(link)
    link
  end

  protected
  attr_accessor :first, :last
end
