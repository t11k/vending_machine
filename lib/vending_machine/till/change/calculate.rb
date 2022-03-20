# frozen_string_literal: true

require_relative 'coins'
require_relative 'partial_change'

module VendingMachine
  module Till
    module Change
      class Calculate
        def initialize(coins:, amount:)
          @coins = coins
          @amount = amount
        end

        def call
          min_change(
            Till::Change::PartialChange.new(
              coins: Till::Change::Coins.new(@coins.to_h),
              amount: @amount,
              change: Till::Change::Coins.new
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
end
