# frozen_string_literal: true

require 'vending_machine/money'

RSpec.describe VendingMachine::Till::Change::Calculate do
  # TEST_CASES: Array of test cases where each test case is an array of 3:
  # [available coins, target change amount, expected result]
  #
  TEST_CASES = [
    [{ 1.0 => 1, 2.0 => 1, 3.0 => 1 }, 4.0, { 1.0 => 1, 3.0 => 1 }],
    [{ 1.0 => 1, 3.0 => 1, 5.0 => 2, 7.0 => 1 }, 14.0, { 5.0 => 2, 3.0 => 1, 1.0 => 1 }],
    [{ 1.0 => 1, 3.0 => 1 }, 5.0, nil]
  ]

  TEST_CASES.each do |test_case|
    context "given coins: #{test_case[0]} and change: #{test_case[1]}" do
      subject do
        described_class.new(
          coins: test_case[0],
          amount: test_case[1]
        ).call
      end

      it "returns #{test_case[2].inspect}" do
        expect(subject&.to_h).to eq(test_case[2])
      end
    end
  end
end
