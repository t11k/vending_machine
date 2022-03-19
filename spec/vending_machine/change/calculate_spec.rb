# frozen_string_literal: true

RSpec.describe VendingMachine::Change::Calculate do
  # TEST_CASES: Array of test cases where each test case is an array of 3:
  # [available coins, target change amount, expected result]
  #
  TEST_CASES = [
    [{ 1 => 1, 2 => 1, 3 => 1 }, 4, { 1 => 1, 3 => 1 }],
    [{ 1 => 1, 3 => 1, 5 => 2, 7 => 1 }, 14, { 5 => 2, 3 => 1, 1 => 1 }],
    [{ 1 => 1, 3 => 1 }, 5, nil]
  ]

  TEST_CASES.each do |test_case|
    context "given coins: #{test_case[0]} and change: #{test_case[1]}" do
      subject do
        described_class.new(
          coins: test_case[0],
          amount: test_case[1]
        ).call
      end

      it { is_expected.to eq(test_case[2]) }
    end
  end
end
