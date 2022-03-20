# frozen_string_literal: true

require_relative 'coin'

module VendingMachine
  module Money
    class Coins
      include Enumerable

      def initialize(coins = {})
        @coins = coins
      end

      def self.empty
        new
      end

      def each
        return enum_for(:each) unless block_given?

        @coins.each do |amount, count|
          yield Coin.new(value: amount, count: count)
        end
      end

      def to_h
        @coins
      end

      def total
        map(&:sum).reduce(:+) || Amount.new(0)
      end

      def empty?
        total.zero?
      end

      def any?
        !empty?
      end

      def add(coin)
        @coins[coin.value.to_f] ||= 0
        @coins[coin.value.to_f] += coin.count
      end

      def remove(coin)
        @coins[coin.value.to_f] -= coin.count
      end
    end
  end
end
