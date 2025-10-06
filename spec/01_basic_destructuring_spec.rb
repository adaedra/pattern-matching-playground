# frozen_string_literal: true

RSpec.describe 'Basic Destructuring' do
  it 'splits values returned by a method' do
    def dummy = [1, 2, 3, 4]

    _ = dummy # TODO

    expect(first).to eq(1)
    expect(second).to eq(2)
    expect(third).to eq(3)
    expect(fourth).to eq(4)
  end

  it 'splits nested structures' do
    def dummy = [1, [2, 3], 4]

    _ = dummy # TODO

    expect(first).to eq(1)
    expect(second).to eq(2)
    expect(third).to eq(3)
    expect(fourth).to eq(4)
  end

  it 'splits as block argument' do
    def dummy = { first: [1, 2], second: [3, 4], third: [5, 6] }
    callback = spy

    dummy.each { |_| callback.call(name, left, right) } # TODO

    expect(callback).to have_received(:call).with(:first, 1, 2).ordered
    expect(callback).to have_received(:call).with(:second, 3, 4).ordered
    expect(callback).to have_received(:call).with(:third, 5, 6).ordered
  end
end
