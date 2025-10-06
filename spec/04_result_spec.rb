# frozen_string_literal: true

require 'result'

RSpec.describe 'Result desconstructing' do
  def dummy(callback, result)
    # TODO
  end

  let(:callback) { spy }

  it 'deconstruct success' do
    dummy(callback, Result::Success.new(1))

    expect(callback).to have_received(:call).with(true, 1)
  end

  it 'deconstruct failure' do
    dummy(callback, Result::Failure.new(2))

    expect(callback).to have_received(:call).with(false, 2)
  end
end
