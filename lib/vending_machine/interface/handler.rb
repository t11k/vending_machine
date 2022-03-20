# frozen_string_literal: true

require 'tty-prompt'

require_relative 'coin_collector'
require_relative 'coin_returner'

module VendingMachine
  module Interface
    class Handler
      def initialize(inventory:)
        @inventory = inventory
        @prompt = TTY::Prompt.new
      end

      def select_product
        @prompt.select("\nSelect a product") do |menu|
          @inventory.products.each do |product|
            menu.choice product, product, disabled: ('(out of stock)' unless @inventory.available?(product))
          end
        end
      end

      def collect_coins(target_amount)
        collector = CoinCollector.new(target_amount)
        collector.call
        collector.collected_coins
      rescue CoinCollector::Aborted
        @prompt.warn("\nAction aborted")
        return_coins(collector.collected_coins)
        {}
      end

      def deliver(product)
        @prompt.say("\nHere is your product:")
        @prompt.ok(product.name)
      end

      def give_back_change(coins)
        return_coins(coins, message: "Here is your change:")
      end

      def change_failed(coins)
        @prompt.error("Aborted: Could not draw a change.")
        return_coins(coins)
      end

      def hello
        @prompt.say("\nWelcome to our Vending Machine!")
        @prompt.warn("To shut down the machine use: ctrl-c")
      end

      def goodby
        @prompt.say("\n\nGOODBYE!\n\n")
      end

      private

      def return_coins(coins, message: 'Returning coins:')
        CoinReturner.new(coins: coins, message: message).call
      end
    end
  end
end
