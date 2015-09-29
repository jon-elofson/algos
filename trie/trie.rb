require 'byebug'

class Trie < Hash
  def initialize
    super
  end


  def lookup(string)
    string.chars.inject(self) do |hash,char|
      if string.index(char) == (string.length - 1) && hash[char]
        return true
      elsif hash[char]
        hash[char]
      else
        return false
      end
    end
  end

  def build(string)
    string.chars.inject(self) do |hash, char|
      hash[char] ||= {}
    end
  end

  def is_compound?(word)
    tmp_str = ''
    compounds = []
    (0..word.length).times do |idx|
      tmp_str += word[idx]
      if self.lookup(word)
        compounds << word
      end
    end
  end



  def longest_compound_word(words)
    trie = Trie.new
    words.each do |word|
      trie.build(word)
    end
    compounds_words = []
  end


end
