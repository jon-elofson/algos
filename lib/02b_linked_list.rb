require_relative "02a_link"


class LinkedList

  attr_accessor :first, :last

  def initialize
    self.first = nil
    self.last = nil
  end

  def [](idx)
    raise 'index out of bounds' if idx < 0
    link = self.first
    idx.times do
      raise 'index out of bounds' if link.next.nil?
      link = link.next
    end
    link
  end

  def pop_link
    if self.last
      last = self.last
      self.last = last.prev if last.prev
      last.remove
      return last
    end
  end

  def pop
    self.pop_link.value
  end

  def unshift_link(link)
    self.first.insert_left(link) if self.first
    self.last = link if self.last.nil?
    self.first = link
  end

  def unshift(value)
    self.unshift_link(Link.new(value))
  end

  def push_link(link)
    self.last.insert_right(link) if self.last
    self.first = link if self.first.nil?
    self.last = link
  end

  def push(value)
    push_link(Link.new(value))
  end

  def shift_link
    first_link = self.first
    self.first = first_link.next
    first_link.remove
    first_link                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
  end

  def shift
    shift_link.value
  end

end
