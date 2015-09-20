require "01a_array_set"

describe ArraySet do
  it "starts out empty" do
    set = ArraySet.new
    expect(set.count).to eq(0)
  end

  it "allows insertion/include?" do
    set = ArraySet.new
    20.times { |i| set.insert(i) }
    expect(set.count).to eq(20)
    20.times { |i| expect(set.include?(i)).to eq(true) }
  end

  it "allows removal" do
    set = ArraySet.new
    20.times { |i| set.insert(i) }
    (0...20).to_a.shuffle.each_with_index do |el, num_removed|
      expect(set.include?(el)).to eq(true)
      set.remove(el)
      expect(set.include?(el)).to eq(false)
      expect(set.count).to eq(20 - (num_removed + 1))
    end
  end
end
