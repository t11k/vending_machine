# frozen_string_literal: true

RSpec.describe VendingMachine::Money::Coin do
  let(:value) { 10.0 }
  let(:count) { 3 }

  subject(:coin) { described_class.new(value: value, count: count) }

  describe '#sum' do
    subject { coin.sum }

    it 'returns a total value' do
      expect(subject).to eq(30.0)
    end
  end
end
