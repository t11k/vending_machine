# frozen_string_literal: true

require_relative 'product'

module VendingMachine
  module Inventory
    class Manager
      class Error < StandardError; end
      class NotAvailable < Error; end

      include Enumerable

      def initialize(config)
        @products = {}
        @quantities = {}

        config.each do |product_config|
          product = Product.new(**product_config.slice(:name, :price))

          @products[product.key] = product
          @quantities[product.key] = product_config[:quantity]
        end
      end

      def products
        @products.values
      end

      def quantity(product)
        @quantities[product.key]
      end

      def available?(product)
        @quantities[product.key] > 0
      end

      def draw(product)
        raise NotAvailable if @quantities[product.key].zero?

        @quantities[product.key] -= 1

        product
      end
    end
  end
end
