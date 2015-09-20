require "01b_max_int_set"

describe MaxIntSet do
  it "starts out empty" do
    set = MaxIntSet.new(8)
    expect(set.count).to eq(0)
  end

  it "allows insertion/include?" do
    set = MaxIntSet.new(8)
    5.times { |i| set.insert(i) }
    expect(set.count).to eq(5)
    5.times { |i| expect(set.include?(i)).to eq(true) }
  end

  it "allows removal" do
    set = MaxIntSet.new(8)
    5.times { |i| set.insert(i) }
    (0...5).to_a.shuffle.each_with_index do |el, num_removed|
      expect(set.include?(el)).to eq(true)
      set.remove(el)
      expect(set.include?(el)).to eq(false)
      expect(set.count).to eq(5 - (num_removed + 1))
    end
  end

  describe "internals" do
    it "provides O(1) include?" do
      set = MaxIntSet.new(8)
      allow(set.send(:store)).to receive(:[]).and_call_original
      set.include?(5)
      expect(set.send(:store)).to have_received(:[]).exactly(1).times
    end

    it "provides O(1) insert" do
      set = MaxIntSet.new(8)

      allow(set.send(:store)).to receive(:[]=).and_call_original
      5.times do |i|
        set.insert(i)
        expect(set.send(:store)).to have_received(:[]=).exactly(i + 1).times
      end
    end

    it "provides O(1) remove" do
      set = MaxIntSet.new(8)

      5.times { |i| set.insert(i) }

      allow(set.send(:store)).to receive(:[]=).and_call_original
      5.times do |i|
        set.remove(i)
        expect(set.send(:store)).to have_received(:[]=).exactly(i + 1).times
      end
    end
  end
end
