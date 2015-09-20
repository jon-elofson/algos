# This is a basic link class.
class Link
  attr_accessor :value
  attr_reader :next, :prev

  def initialize(value)
    self.value = value
  end

  # Add the link before us
  def insert_left(link)
    unless link.is_detached?
      raise "trying to insert a link that's not detached!"
    end

    link.next = self
    link.prev = self.prev
    self.prev.next = link if self.prev
    self.prev = link

    nil
  end

  # Add the link after us
  def insert_right(link)
    unless link.is_detached?
      raise "trying to insert a link that's not detached!"
    end

    link.prev = self
    link.next = self.next
    self.next.prev = link if self.next
    self.next = link

    nil
  end

  def is_detached?
    !(self.next || self.prev)
  end

  def remove
    self.prev.next, self.next.prev = self.next, self.prev
    self.prev, self.next = nil, nil
  end

  protected
  attr_writer :next, :prev
end
