# frozen_string_literal: true

require 'tty-prompt'

module VendingMachine
  module Interface
    class CoinReturner
      def initialize(coins:, message: '')
        @coins = coins
        @message = message
        @prompt = TTY::Prompt.new
      end

      def call
        return if @coins.empty?

        @prompt.say("\n#{@message}")
        @coins.each do |coin|
          coin.count.times { @prompt.ok(coin) }
        end
      end
    end
  end
end
