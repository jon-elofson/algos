class Trie < Hash
  def initialize
    super
  end

  def build(string)
    string.chars.inject(self) do |h, char|
      h[char] ||= { }
    end
  end

  
end
