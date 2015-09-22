class BinaryMinHeap

  def initialize
    @store = []
  end

  def self.child_indices(length,parent)
    [parent * 2 + 1, parent * 2 + 2].select { |idx| idx < length }
  end

  def self.parent_index(idx)
    raise 'root has no parent' if idx == 0
    if idx % 2 != 0
      return idx / 2
    else
      return idx / 2 - 1
    end
  end

  def self.find_best_index(idx1,idx2,heap,&prc)
    return idx1 if !idx2
    case prc.call(heap[idx1],heap[idx2])
    when -1
      idx1
    when 0
      idx1
    when 1
      idx2
    end
  end


  def self.heapify_down(heap,start_index,&prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    idx1, idx2 = self.child_indices(heap.length,start_index)
    return heap if !idx1 && !idx2
    target = self.find_best_index(idx1,idx2,heap,&prc)
    if target && prc.call(heap[target],heap[start_index]) == -1
      heap[start_index], heap[target] = heap[target], heap[start_index]
      self.heapify_down(heap,target,&prc)
    else
      return heap
    end
  end

  def self.heapify_up(heap,start_index,&prc)
    begin
      parent = self.parent_index(start_index)
    rescue
      return heap
    end
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    if prc.call(heap[parent],heap[start_index]) == 1
      heap[parent],heap[start_index] = heap[start_index],heap[parent]
      self.heapify_up(heap,parent,&prc)
    else
      return heap
    end
  end

  #instance methods

  attr_accessor :store


  def initialize
    @store = []
  end

  def push(value)
    @store << value
    @store = BinaryMinHeap.heapify_up(@store,(@store.length - 1))
  end

  def extract
      result = @store[0]
      @store[0] = @store.pop
      @store = BinaryMinHeap.heapify_down(@store,0)
      return result
  end

end
