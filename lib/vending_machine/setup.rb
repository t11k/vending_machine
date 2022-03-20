# frozen_string_literal: true

require_relative "config"
require_relative 'inventory'
require_relative 'till'
require_relative 'interface'
require_relative 'machine'

module VendingMachine
  class Setup
    def self.call
      inventory = Inventory::Manager.new(Config.initial_inventory)
      till = Till::Drawer.new(Config.initial_till)
      interface = Interface::Handler.new(inventory: inventory)

      Machine.new(
        inventory: inventory,
        till: till,
        interface: interface
      )
    end
  end
end
