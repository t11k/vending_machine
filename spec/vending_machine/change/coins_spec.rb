# frozen_string_literal: true

RSpec.describe VendingMachine::Change::Coins do
  let(:raw_coins) { {} }

  subject(:coins) do
    described_class.new(raw_coins)
  end

  describe '#each' do
    let(:raw_coins) do
      {
        1 => 1,
        2 => 2
      }
    end

    subject { coins.each }

    it 'returns an Enumerator' do
      expect(subject).to be_a(Enumerator)
    end

    it 'yields Coin objects' do
      expect(subject.to_a).to all(be_a(VendingMachine::Change::Coin))
    end

    it 'yields all the coins' do
      result = subject.to_a

      expect(result[0].value).to eq(1)
      expect(result[0].count).to eq(1)

      expect(result[1].value).to eq(2)
      expect(result[1].count).to eq(2)
    end
  end

  describe '#lteq(amount)' do
    let(:raw_coins) do
      {
        2 => 1,
        5 => 0,
        10 => 4,
        11 => 1,
        20 => 0
      }
    end
    let(:amount) { 10 }

    subject { coins.lteq(amount) }

    it 'returns a Coins object' do
      expect(subject).to be_a(VendingMachine::Change::Coins)
    end

    it 'returns coins which are present and are <= amount' do
      expect(subject.coins).to match({ 2 => 1, 10 => 4 })
    end
  end

  describe '#count' do
    let(:raw_coins) do
      {
        1 => 1,
        2 => 2,
        3 => 3
      }
    end

    subject { coins.count }

    it 'returns a number of all coins' do
      expect(subject).to eq(6)
    end
  end

  describe '#without(coin)' do
    let(:raw_coins) do
      {
        1 => 1,
        2 => 1,
        3 => 1
      }
    end
    let(:coin) { double(value: 2) }

    subject { coins.without(coin) }

    it 'returns a Coins object' do
      expect(subject).to be_a(VendingMachine::Change::Coins)
    end

    it 'returns coins with one coin with given value removed' do
      expect(subject.coins).to match({ 1 => 1, 2 => 0, 3 => 1})
    end

    it 'does not modify original coins' do
      expect { subject }.not_to change { raw_coins }
    end
  end

  describe '#with(coin)' do
    let(:raw_coins) do
      {
        1 => 1,
        3 => 1
      }
    end
    let(:coin) { double(value: 2) }

    subject { coins.with(coin) }

    it 'returns a Coins object' do
      expect(subject).to be_a(VendingMachine::Change::Coins)
    end

    it 'returns coins with one coin with given value added' do
      expect(subject.coins).to match({ 1 => 1, 2 => 1, 3 => 1})
    end

    it 'does not modify original coins' do
      expect { subject }.not_to change { raw_coins }
    end
  end
end
