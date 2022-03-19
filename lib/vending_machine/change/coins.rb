# frozen_string_literal: true

require 'vending_machine/change/coin'

module VendingMachine
  module Change
    class Coins
      include Enumerable

      attr_reader :coins

      def initialize(coins = {})
        @coins = coins
      end

      def each
        return enum_for(:each) unless block_given?

        @coins.each do |value, count|
          yield Coin.new(value: value, count: count)
        end
      end

      def lteq(amount)
        Coins.new(
          @coins.select { |coin, count|
            (count > 0) && (coin <= amount)
          }
        )
      end

      def count
        @coins.values.sum
      end

      def without(coin)
        coins = @coins.dup
        coins[coin.value] -= 1

        Coins.new(coins)
      end

      def with(coin)
        coins = @coins.dup
        coins[coin.value] ||= 0
        coins[coin.value] += 1

        Coins.new(coins)
      end
    end
  end
end
