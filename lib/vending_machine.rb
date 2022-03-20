# frozen_string_literal: true

require_relative "vending_machine/version"
require_relative "vending_machine/setup"

module VendingMachine
  class Error < StandardError; end

  def self.start
    machine = Setup.call
    machine.run
  end
end
