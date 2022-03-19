# frozen_string_literal: true
#
require 'vending_machine/change/coins'

RSpec.describe VendingMachine::Change::PartialChange do
  let(:coins) { double(:coins) }
  let(:change) { double(:change) }
  let(:amount) { 0 }

  subject(:partial_change) do
    described_class.new(
      coins: coins,
      change: change,
      amount: amount
    )
  end

  describe '#complete?' do
    subject { partial_change.complete? }

    context 'when amount equals 0' do
      let(:amount) { 0 }

      it { is_expected.to be true }
    end

    context 'when amount is not 0' do
      let(:amount) { 200 }

      it { is_expected.to be false }
    end
  end

  describe '#applicable_coins' do
    subject { partial_change.applicable_coins }

    it 'returns coins which are less than or equal to current amount' do
      applicable_coins = double(:applicable_coins)

      allow(coins)
        .to receive(:lteq)
        .with(amount)
        .and_return(applicable_coins)

      expect(subject).to eq(applicable_coins)
    end
  end
end
