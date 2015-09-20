require_relative '03_heap'

class Array
  def heap_sort!
    2.upto(count).each do |heap_sz|
      BinaryMinHeap.heapify_up(self, heap_sz - 1, heap_sz)
    end

    count.downto(2).each do |heap_sz|
      self[heap_sz - 1], self[0] = self[0], self[heap_sz - 1]
      BinaryMinHeap.heapify_down(self, 0, heap_sz - 1)
    end

    self.reverse!
  end
end

fail unless [6, 3, 4, 5, 1, 2].heap_sort! == [1, 2, 3, 4, 5, 6]
fail unless [1, 4, 7, 0].heap_sort! == [0, 1, 4, 7]
