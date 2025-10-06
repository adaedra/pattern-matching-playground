# frozen_string_literal: true

module Result
  Success = Data.define(:value) do
    def success? = true
  end

  Failure = Data.define(:value) do
    def success? = false
  end
end
