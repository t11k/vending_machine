# frozen_string_literal: true

module VendingMachine
  module Till
    module Change
      class PartialChange
        attr_reader :change

        def initialize(coins:, amount:, change:)
          @coins = coins
          @change = change
          @amount = amount
        end

        def complete?
          @amount == 0
        end

        def applicable_coins
          @applicable_coins ||= @coins.lteq(@amount)
        end

        def apply(coin)
          PartialChange.new(
            coins: applicable_coins.without(coin.value),
            amount: @amount - coin.value,
            change: @change.with(coin.value)
          )
        end

        def number_of_coins
          @change.count
        end

        def <=>(other_change)
          number_of_coins <=> other_change.number_of_coins
        end
      end
    end
  end
end
