# This is a basic link class.
class Link

  attr_accessor :value, :next, :prev

  def initialize(value,next_link=nil,prev_link=nil)
    @value = value
    @next = next_link
    @prev = prev_link
  end

  def insert_left(link)
    link.next = self
    if @prev
      @prev.next = link
      link.prev = @prev
    end
    self.prev = link
  end

  def insert_right(link)
    link.prev = self
    if @next
      @next.prev = link
      link.next = @next
    end
    self.next = link
  end

  def remove
    if @next && @prev
      @next.prev = @prev
      @prev.next = @next
    elsif @prev
      @prev.next = nil
    elsif @next
      @next.prev = nil
    end
    self.next = nil
    self.prev = nil
  end


end
