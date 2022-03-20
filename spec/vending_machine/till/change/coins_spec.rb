# frozen_string_literal: true

require 'vending_machine/money'

RSpec.describe VendingMachine::Till::Change::Coins do
  let(:raw_coins) { {} }

  subject(:coins) do
    described_class.new(raw_coins)
  end

  describe '#lteq(amount)' do
    let(:raw_coins) do
      {
        2.0 => 1,
        5.0 => 0,
        10.0 => 4,
        11.0 => 1,
        20.0 => 0
      }
    end
    let(:amount) { 10 }

    subject { coins.lteq(amount) }

    it 'returns a Coins object' do
      expect(subject).to be_a(VendingMachine::Till::Change::Coins)
    end

    it 'returns coins which are present and are <= amount' do
      expect(subject.to_h).to match({ 2.0 => 1, 10.0 => 4 })
    end
  end

  describe '#count' do
    let(:raw_coins) do
      {
        1.0 => 1,
        2.0 => 2,
        3.0 => 3
      }
    end

    subject { coins.count }

    it 'returns a number of all coins' do
      expect(subject).to eq(6)
    end
  end

  describe '#without(value)' do
    let(:raw_coins) do
      {
        1.0 => 1,
        2.0 => 1,
        3.0 => 1
      }
    end
    let(:value) { 2.0 }

    subject { coins.without(value) }

    it 'returns a Coins object' do
      expect(subject).to be_a(VendingMachine::Till::Change::Coins)
    end

    it 'returns coins with one coin with given value removed' do
      expect(subject.to_h).to match({ 1.0 => 1, 2.0 => 0, 3.0 => 1})
    end

    it 'does not modify original coins' do
      expect { subject }.not_to change { raw_coins }
    end
  end

  describe '#with(value)' do
    let(:raw_coins) do
      {
        1.0 => 1,
        3.0 => 1
      }
    end
    let(:value) { 2.0 }

    subject { coins.with(value) }

    it 'returns a Coins object' do
      expect(subject).to be_a(VendingMachine::Till::Change::Coins)
    end

    it 'returns coins with one coin with given value added' do
      expect(subject.to_h).to match({ 1.0 => 1, 2.0 => 1, 3.0 => 1})
    end

    it 'does not modify original coins' do
      expect { subject }.not_to change { raw_coins }
    end
  end
end
