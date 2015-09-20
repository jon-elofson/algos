require "02a_link"

describe Link do
  it "allows insertion to the left" do
    link1 = Link.new(1)
    link2 = Link.new(2)

    link2.insert_left(link1)
    expect(link1.next).to eq(link2)
    expect(link1.prev).to eq(nil)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link1)

    link3 = Link.new(3)
    link2.insert_left(link3)
    expect(link1.next).to eq(link3)
    expect(link1.prev).to eq(nil)
    expect(link3.next).to eq(link2)
    expect(link3.prev).to eq(link1)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link3)
  end

  it "allows insertion to the right" do
    link1 = Link.new(1)
    link2 = Link.new(2)

    link1.insert_right(link2)
    expect(link1.next).to eq(link2)
    expect(link1.prev).to eq(nil)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link1)

    link3 = Link.new(3)
    link1.insert_right(link3)
    expect(link1.next).to eq(link3)
    expect(link1.prev).to eq(nil)
    expect(link3.next).to eq(link2)
    expect(link3.prev).to eq(link1)
    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(link3)
  end

  it "allows removal" do
    link1 = Link.new(1)
    link2 = Link.new(2)
    link3 = Link.new(3)

    link1.insert_right(link2)
    link2.insert_right(link3)

    link2.remove

    expect(link1.next).to eq(link3)
    expect(link1.prev).to eq(nil)
    expect(link3.next).to eq(nil)
    expect(link3.prev).to eq(link1)

    expect(link2.next).to eq(nil)
    expect(link2.prev).to eq(nil)
  end
end
