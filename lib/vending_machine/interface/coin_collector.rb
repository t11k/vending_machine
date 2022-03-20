# frozen_string_literal: true

require 'tty-prompt'
require_relative '../money'

module VendingMachine
  module Interface
    class CoinCollector
      class Error < StandardError; end
      class Aborted < Error; end

      OPTIONS = Config::DENOMINATIONS.map do |denomination|
        Money::Coin.new(value: denomination, count: 1)
      end

      attr_reader :collected_coins

      def initialize(target_amount)
        @target_amount = target_amount
        @collected_coins = Money::Coins.new

        @prompt = TTY::Prompt.new
        @prompt.on(:keyescape) { raise Aborted }
      end

      def call
        @prompt.say("\nInsert coins (press ESC to abort):\n\n")

        while missing_amount > 0
          @collected_coins.add(collect_coin)
        end
      end

      private

      def missing_amount
        @target_amount - collected_amount
      end

      def collected_amount
        @collected_coins.total
      end

      def collect_coin
        @prompt.select("Amount: #{collected_amount} (missing: #{missing_amount})", OPTIONS)
      end
    end
  end
end
