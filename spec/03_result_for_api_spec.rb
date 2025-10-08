# frozen_string_literal: true

require 'result'

RSpec.describe 'Result for API' do
  def result_for_api(status, api)
    case [status, api]
    in [200, {}]
      Result::Success.new(nil)
    in [200, { success: false, **rest }]
      result_for_api(500, rest)
    in [200, { success: _, payload:, **nil }]
      Result::Success.new(payload)
    in [200, { payload:, **nil }]
      Result::Success.new(payload)
    in [200, { success: _, **payload }]
      Result::Success.new(payload)
    in [200, payload]
      Result::Success.new(payload)
    in [500, String => error]
      Result::Failure.new([error])
    in [500, {}]
      Result::Failure.new([])
    in [500, { errors: }]
      Result::Failure.new(errors)
    in [500, { error: }]
      Result::Failure.new([error])
    end
  end

  context 'status OK' do
    it 'reads empty object' do
      result = result_for_api(200, {})

      expect(result).to be_success
      expect(result.value).to be_nil
    end

    it 'honors success=false as failure' do
      result = result_for_api(200, { success: false })

      expect(result).not_to be_success
      expect(result.value).to eq([])
    end

    it 'reads payload form payload field' do
      result = result_for_api(200, { payload: { foo: 'bar' } })

      expect(result).to be_success
      expect(result.value).to eq({ foo: 'bar' })
    end

    it 'reads payload directly if there is no payload field' do
      result = result_for_api(200, { foo: 'bar' })

      expect(result).to be_success
      expect(result.value).to eq({ foo: 'bar' })
    end

    it 'ignores success field in payload' do
      result = result_for_api(200, { success: true, foo: 'bar' })

      expect(result).to be_success
      expect(result.value).to eq({ foo: 'bar' })
    end

    it 'reads payload if there is both payload and success' do
      result = result_for_api(200, { success: true, payload: { foo: 'bar' } })

      expect(result).to be_success
      expect(result.value).to eq({ foo: 'bar' })
    end
  end

  context 'status Error' do
    it 'reads empty object' do
      result = result_for_api(500, {})

      expect(result).not_to be_success
      expect(result.value).to eq([])
    end

    it 'reads string' do
      result = result_for_api(500, 'something wrong')

      expect(result).not_to be_success
      expect(result.value).to eq(['something wrong'])
    end

    it 'reads string as error field' do
      result = result_for_api(500, { error: 'something wrong' })

      expect(result).not_to be_success
      expect(result.value).to eq(['something wrong'])
    end

    it 'reads array as errors field' do
      result = result_for_api(500, { errors: ['oh no', 'oops'] })

      expect(result).not_to be_success
      expect(result.value).to eq(['oh no', 'oops'])
    end
  end
end
