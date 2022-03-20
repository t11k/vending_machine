# frozen_string_literal: true

require_relative 'interface/handler'

module VendingMachine
  class Machine
    attr_reader :inventory, :till, :interface

    def initialize(inventory:, till:, interface:)
      @inventory = inventory
      @till = till
      @interface = interface
    end

    def run
      loop do
        product = interface.select_product
        coins = interface.collect_coins(product.price)

        if coins.any?
          change = till.prepare_change(coins.total - product.price)
          if change.nil?
            interface.change_failed(coins)
          else
            till.store(coins)
            inventory.draw(product)
            interface.deliver(product)
            if change.any?
              till.draw(change)
              interface.give_back_change(change)
            end
          end
        end
      end
    end
  end
end
