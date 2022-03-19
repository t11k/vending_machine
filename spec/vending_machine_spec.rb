# frozen_string_literal: true

RSpec.describe VendingMachine do
  it "has a version number" do
    expect(VendingMachine::VERSION).not_to be nil
  end
end
