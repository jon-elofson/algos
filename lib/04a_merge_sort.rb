class MergeSort
  # Uses O(n) memory. Always takes O(nlogn) time.
  def self.sort(array, &prc)
    return array.dup if array.length < 2

    left_size = array.length / 2
    merge(
      sort(array.take(left_size), &prc),
      sort(array.drop(left_size), &prc),
      &prc
    )
  end

  def self.merge(left, right, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    merged = []

    # Note how I carefully avoid shifting out of left or right. That's
    # an O(n) operation and doing it n times would make merge O(n**2).
    left_idx, right_idx = 0, 0
    until (left_idx == left.length) && (right_idx == right.length)
      if (left_idx == left.length)
        # used everything on the left; only stuff on the right remains
        merged << right[right_idx]
        right_idx += 1
      elsif right_idx == right.length
        # used everything on the right; only stuff on the left remains
        merged << left[left_idx]
        left_idx += 1
      elsif prc.call(left[left_idx], right[right_idx]) < 1
        merged << left[left_idx]
        left_idx += 1
      else
        merged << right[right_idx]
        right_idx += 1
      end
    end

    merged
  end
end
