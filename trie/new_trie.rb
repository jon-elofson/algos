require 'byebug'

class TrieNode

  attr_accessor :is_terminal, :children

  def initialize(is_terminal=false)
    @is_terminal = is_terminal
    @children = {}
  end


end


class Trie

  def initialize(words=[])
    @root = TrieNode.new
    words.each do |word|
      self.insert(word)
    end
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
      if next_node
        current = next_node
      else
        current = nil
      end
    end
    return current
  end

  def autocomplete(prefix)
    last_node = find_last_node(prefix)
    if last_node.nil?
      return []
    else
      suffixes = all_suffixes(last_node)
      suffixes.map { |suffix| prefix + suffix }
    end
  end

  def all_suffixes(node)
    if node.children.empty?
       return ['']
    end
    result = []
    children = node.children
    children.each do |ltr,nd|
      next_suffixes = all_suffixes(nd)
      result += next_suffixes.map { |suff| ltr + suff }
    end
    result
  end

end
