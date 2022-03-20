# frozen_string_literal: true

require_relative 'change/calculate'

module VendingMachine
  module Till
    class Drawer
      attr_reader :coins

      def initialize(coins)
        @coins = Money::Coins.new(coins)
      end

      def prepare_change(amount)
        return Money::Coins.empty if amount.zero?

        Change::Calculate.new(coins: @coins, amount: amount).call
      end

      def draw(coins)
        coins.each { |coin| @coins.remove(coin) }
      end

      def store(coins)
        coins.each { |coin| @coins.add(coin) }
      end
    end
  end
end
