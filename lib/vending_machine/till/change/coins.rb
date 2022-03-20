# frozen_string_literal: true

require_relative '../../money'

module VendingMachine
  module Till
    module Change
      class Coins < Money::Coins
        def lteq(amount)
          Till::Change::Coins.new(
            @coins.select { |coin, count|
              (count > 0) && (coin <= amount)
            }
          )
        end

        def count
          @coins.values.sum
        end

        def without(value)
          duplicate.tap do |coins|
            coins.remove(coin(value))
          end
        end

        def with(value)
          duplicate.tap do |coins|
            coins.add(coin(value))
          end
        end

        private

        def duplicate
          Change::Coins.new(@coins.dup)
        end

        def coin(value)
          Money::Coin.new(value: value)
        end
      end
    end
  end
end
