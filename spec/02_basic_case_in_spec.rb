# frozen_string_literal: true

RSpec.describe 'Basic case..in' do
  def to_num(value)
    # TODO
  end

  it 'leaves Numeric as is' do
    expect(to_num(3)).to eq(3)
  end

  it 'converts strings' do
    expect(to_num('3')).to eq(3)
  end

  it 'converts symbols' do
    expect(to_num(:'3')).to eq(3)
  end

  it 'rejects unknown types' do
    expect { to_num(Object.new) }.to raise_error(NoMatchingPatternError)
  end
end
