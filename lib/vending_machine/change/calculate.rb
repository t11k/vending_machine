# frozen_string_literal: true

require 'vending_machine/change/coins'
require 'vending_machine/change/partial_change'

module VendingMachine
  module Change
    class Calculate
      def initialize(coins:, amount:)
        @coins = coins
        @amount = amount
      end

      def call
        min_change(
          PartialChange.new(
            coins: Coins.new(@coins),
            amount: @amount,
            change: Coins.new
          )
        )&.change
      end

      private

      def min_change(partial_change)
        if partial_change.complete?
          return partial_change
        else
          partial_change
            .applicable_coins
            .map { |coin| min_change(partial_change.apply(coin)) }
            .compact
            .min
        end
      end
    end
  end
end