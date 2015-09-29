class TrieNode

  attr_accessor :is_terminal, :children

  def initialize(is_terminal=false)
    @is_terminal = is_terminal
    @children = {}
  end


end


class Trie

  def initialize
    @root = TrieNode.new
  end


  def insert(word)
    current = @root
    word.length.times do |idx|
      letter = word[idx]
      child = current.children[letter]
      if child.nil?
        child = TrieNode.new
        current.children[letter] = child
      end
      child.is_terminal = true if idx == (word.length - 1)
      current = child
    end
  end

  def match?(word)
    current = @root
    word.each_char do |chr|
      next_node = current.children[chr]
      if next_node
        current = next_node
      else
        return false
      end
    end
    current.is_terminal
  end

  def find_last_node(prefix)
    current = @root
    prefix.each_char do |chr|
      next_node = current.children[chr]
      if next_chr
        current = next_node
      else
        raise 'no word matches prefix!'
      end
    end
    return current
  end

  def autocomplete(prefix)
    last_node = find_last_node(prefix)
    suffixes = all_suffixes(node)
    suffixes.map( |suffix| prefix + suffex)
  end

  def all_suffixes(node)
    result = []
    children = node.children
    children.each do |letter,node|
      next_suffixes = all_suffixes(node)
      next_suffixes.each do |suff|
        result << letter + suff
      end
    end
    result
  end





end
