# frozen_string_literal: true

require 'vending_machine/inventory/product'

module VendingMachine
  module Inventory
    class Manager
      class Error < StandardError; end
      class NotAvailable < Error; end

      attr_reader :products

      def initialize(config)
        @products = {}
        @quantities = {}

        config.each do |product_config|
          product = Product.new(**product_config.slice(:name, :price))

          @products[product.key] = product
          @quantities[product.key] = product_config[:quantity]
        end
      end

      def quantity(product)
        @quantities[product.key]
      end

      def available_products
        keys = @quantities.select { |_, quantity| quantity > 0 }.keys
        @products.values_at(*keys)
      end

      def draw(product)
        raise NotAvailable if @quantities[product.key].zero?

        @quantities[product.key] -= 1

        product
      end
    end
  end
end
