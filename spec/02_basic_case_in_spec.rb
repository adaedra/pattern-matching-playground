# frozen_string_literal: true

RSpec.describe 'Basic case..in' do
  def to_num(value)
    case value
    in Numeric
      value
    in String
      value.to_i
    in Symbol
      value.to_s.to_i
    end
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
