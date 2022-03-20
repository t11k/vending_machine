# frozen_string_literal: true

module VendingMachine
  module Inventory
    class Product
      attr_reader :name, :price

      def initialize(name:, price:)
        @name = name
        @price = price
      end

      def key
        name.hash
      end

      def to_s
        "#{name} ($#{'%.2f' % price})"
      end
    end
  end
end
