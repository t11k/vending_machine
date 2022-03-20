# frozen_string_literal: true

module VendingMachine
  module Money
    class Amount < SimpleDelegator
      def -(other_amount)
        Amount.new(super)
      end

      def +(other_amount)
        Amount.new(super)
      end

      def *(number)
        Amount.new(super)
      end

      def to_s
        format
      end

      def format
        "$%0.2f" % self
      end
    end
  end
end