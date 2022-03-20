# frozen_string_literal: true

require_relative 'amount'

module VendingMachine
  module Money
    class Coin
      attr_reader :value, :count

      def initialize(value:, count: 1)
        @value = Money::Amount.new(value)
        @count = count
      end

      def sum
        value * count
      end

      def to_s
        value.to_s
      end
    end
  end
end
