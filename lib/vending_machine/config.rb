module VendingMachine
  module Config
    DENOMINATIONS = [5.0, 3.0, 2.0, 1.0, 0.5, 0.25].freeze

    INITIAL_INVENTORY = [
      { name: 'Coca Cola', price: 2.00, quantity: 10 },
      { name: 'Sprite', price: 2.50, quantity: 10 },
      { name: 'Fanta', price: 2.25, quantity: 10 },
      { name: 'Orange Juice', price: 3.00, quantity: 10 },
      { name: 'Water', price: 3.25, quantity: 0 },
    ]

    INITIAL_TILL = {
      5.0 => 5,
      3.0 => 5,
      2.0 => 5,
      1.0 => 5,
      0.5 => 5,
      0.25 => 5
    }

    def self.initial_inventory
      INITIAL_INVENTORY
    end

    def self.initial_till
      INITIAL_TILL
    end
  end
end