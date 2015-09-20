require "02b_linked_list"

describe LinkedList do
  it "pushes links into the list" do
    list = LinkedList.new
    list.push_link(link1 = Link.new(1))
    list.push_link(link2 = Link.new(2))
    list.push_link(link3 = Link.new(3))

    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link3)
  end

  it "pushes values into the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link3)
  end

  it "raises error on out of bounds access" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "pops links from the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.pop_link).to eq(link3)

    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "pops values from the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.pop).to eq(3)
    expect(list[0]).to eq(link1)
    expect(list[1]).to eq(link2)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "unshifts links into the list" do
    list = LinkedList.new
    list.unshift_link(link1 = Link.new(1))
    list.unshift_link(link2 = Link.new(2))
    list.unshift_link(link3 = Link.new(3))

    expect(list[0]).to eq(link3)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link1)
  end

  it "unshifts values into the list" do
    list = LinkedList.new
    link1 = list.unshift(1)
    link2 = list.unshift(2)
    link3 = list.unshift(3)

    expect(list[0]).to eq(link3)
    expect(list[1]).to eq(link2)
    expect(list[2]).to eq(link1)
  end

  it "shifts links out of the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.shift_link).to eq(link1)

    expect(list[0]).to eq(link2)
    expect(list[1]).to eq(link3)

    expect do
      list[2]
    end.to raise_error("index out of bounds")
  end

  it "shift values out of the list" do
    list = LinkedList.new
    link1 = list.push(1)
    link2 = list.push(2)
    link3 = list.push(3)

    expect(list.shift).to eq(1)

    expect(list[0]).to eq(link2)
    expect(list[1]).to eq(link3)
  end
end

# TODO: Test internals.
# TODO: Test what happens when you call remove on links. Especially
# when the list goes empty.
