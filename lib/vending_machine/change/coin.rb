# frozen_string_literal: true

module VendingMachine
  module Change
    class Coin
      attr_reader :value, :count

      def initialize(value:, count:)
        @value = value
        @count = count
      end
    end
  end
end
