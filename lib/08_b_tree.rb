class Array
  def sorted_insert(value)
    # could even do bsearch...
    length.times do |idx|
      next unless value < self[idx]

      insert(idx, value)
      return idx
    end

    self << value
    self.length - 1
  end
end

class BTreeNode
  attr_reader :max_size

  def initialize(max_size, parent, values = [], children = nil)
    @max_size, @parent = max_size, parent
    @values, @children = values, children
  end

  def child_for(value)
    raise "Hell" if leaf?

    # could even do bsearch...
    values.length.times do |value_idx|
      return children[value_idx] if value < values[value_idx]
    end

    children.last
  end

  def full?
    values.length == max_size
  end

  def include?(value)
    values.include?(value) ||
      (!leaf? && child_for(value).include?(value))
  end

  def insert(value)
    return if values.include?(value)

    if !leaf?
      return child_for(value).insert(value)
    else
      return _insert(value, nil)
    end
  end

  def leaf?
    children.nil?
  end

  def min_size
    # need (2*min_sz + 1) == (max_sz + 1)
    max_size / 2
  end

  def printify
    { object_id: object_id,
      parent: root? ? nil : parent.object_id,
      values: values,
      children: leaf? ? nil : children.map(&:printify) }
  end

  def root?
    parent.nil?
  end

  def size
    values.length
  end

  protected
  attr_accessor :children, :max_size, :parent, :values

  def _append_child(new_child)
    children << new_child
    new_child.parent = self
  end

  def _insert(new_value, new_node)
    raise "Hell" unless new_node.nil? == leaf?

    idx = values.sorted_insert(new_value)
    children.insert(idx, new_node) unless leaf?

    # careful to return new root if we are splitting.
    (size > max_size) ? _split! : nil
  end

  def _split!
    raise "Hell" unless size > max_size

    left = BTreeNode.new(max_size, parent, [], leaf? ? nil : [])
    until left.size >= left.min_size
      left.values << values.shift 
      left._append_child(children.shift) unless leaf?
    end

    new_split_value = values.shift
    left._append_child(children.shift) unless leaf?

    if root?
      new_root = BTreeNode.new(max_size, nil, [], [])
      new_root.values << new_split_value
      new_root._append_child(left)
      new_root._append_child(self)
      return new_root
    else
      return parent._insert(new_split_value, left)
    end
  end
end

class BTree
  def initialize(max_size)
    @root = BTreeNode.new(max_size, nil)
  end

  def include?(value)
    @root.include?(value)
  end

  def insert(value)
    new_root = @root.insert(value)
    @root = new_root unless new_root.nil?

    nil
  end

  def printify
    @root.printify
  end
end

def main
  require 'pry'

  $bt = BTree.new(2)

  [60, 30, 70, 40, 20, 10, 50, 80].each do |val|
    $bt.insert(val)
  end

  # * 30, 60
  #     * 10, 20
  #     * 40, 50
  #     * 70, 80

  binding.pry

  $bt.insert(45)
  # * 45
  #     * 30
  #         * 10, 20
  #         * 40
  #     * 60
  #         * 50
  #         * 70, 80


  binding.pry
end

main if __FILE__ == $PROGRAM_NAME
