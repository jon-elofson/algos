require "04a_merge_sort"

describe MergeSort do
  describe "::merge" do
    it "merges two sorted arrays" do
      expect(MergeSort.merge([1, 3, 5], [2, 4, 6])).to eq([1, 2, 3, 4, 5, 6])
    end

    it "doesn't use shift or pop" do
      arr1 = [1, 3, 5]
      arr2 = [2, 4, 6]

      expect(arr1).not_to receive(:shift)
      expect(arr1).not_to receive(:pop)
      expect(arr2).not_to receive(:shift)
      expect(arr2).not_to receive(:pop)
      MergeSort.merge(arr1, arr2)
    end

    it "uses a block" do
      result = MergeSort.merge([5, 3, 1], [4, 2, 0]) do |el1, el2|
        -1 * (el1 <=> el2)
      end

      expect(result).to eq([5, 4, 3, 2, 1, 0])
    end

    it "makes the optimal number of comparisons" do
      arr1 = [1, 3, 5, 7]
      arr2 = [2, 4, 6, 8]

      num_comps = 0
      MergeSort.merge(arr1, arr2) do |el1, el2|
        num_comps += 1
        el1 <=> el2
      end

      expect(num_comps).to eq(7)
    end
  end

  describe "::sort" do
    let(:counting_block) do
      @comparison_count = 0
      Proc.new do |el1, el2|
        @comparison_count += 1
        el1 <=> el2
      end
    end

    it "sorts an array" do
      expect(MergeSort.sort([5, 3, 4, 2, 1])).to eq([1, 2, 3, 4, 5])
    end

    it "uses a block" do
      result = MergeSort.sort([1, 2, 3, 4, 5]) do |el1, el2|
        -1 * (el1 <=> el2)
      end

      expect(result).to eq([5, 4, 3, 2, 1])
    end

    it "small expected comparisons" do
      arr = [1, 2]
      MergeSort.sort(arr, &counting_block)
      expect(@comparison_count).to eq(1)
    end

    it "more expected comparisons" do
      arr = [2, 4, 1, 3]
      MergeSort.sort(arr, &counting_block)
      expect(@comparison_count).to eq(5)
    end

    it "large number of comparisons" do
      arr = [2, 6, 4, 8, 1, 5, 3, 7]

      MergeSort.sort(arr, &counting_block)
      expect(@comparison_count).to eq(17)
    end
  end
end
