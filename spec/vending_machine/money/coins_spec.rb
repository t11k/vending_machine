# frozen_string_literal: true

RSpec.describe VendingMachine::Money::Coins do
  let(:raw_coins) { {} }

  subject(:coins) do
    described_class.new(raw_coins)
  end

  describe '.empty' do
    subject { described_class.empty }

    it { is_expected.to be_a(described_class) }
    it { is_expected.to be_empty }
  end

  describe '#each' do
    let(:raw_coins) do
      {
        1.0 => 1,
        2.0 => 2
      }
    end

    subject { coins.each }

    it 'returns an Enumerator' do
      expect(subject).to be_a(Enumerator)
    end

    it 'yields Coin objects' do
      expect(subject.to_a).to all(be_a(VendingMachine::Money::Coin))
    end

    it 'yields all the coins' do
      result = subject.to_a

      expect(result[0].value).to eq(1.0)
      expect(result[0].count).to eq(1)

      expect(result[1].value).to eq(2.0)
      expect(result[1].count).to eq(2)
    end
  end

  describe '#to_h' do
    let(:raw_coins) do
      {
        1.0 => 1,
        2.0 => 2
      }
    end
    subject { coins.to_h }

    it { is_expected.to eq(raw_coins) }
  end

  describe '#total' do
    let(:raw_coins) do
      {
        1.0 => 1,
        2.0 => 2,
        3.0 => 3
      }
    end
    subject { coins.total }

    it { is_expected.to eq(14.0) }
  end

  describe '#empty?' do
    context 'when total amount is zero' do
      let(:raw_coins) do
        {
          1.0 => 0,
          2.0 => 0
        }
      end
      subject { coins.empty? }

      it { is_expected.to be true }
    end

    context 'when total amount is positive' do
      let(:raw_coins) do
        {
          1.0 => 1,
          2.0 => 0
        }
      end
      subject { coins.empty? }

      it { is_expected.to be false }
    end
  end

  describe '#add' do
    context 'when existing coin' do
      let(:coin) { double(value: 2.0, count: 2) }
      let(:raw_coins) do
        {
          1.0 => 1,
          2.0 => 2
        }
      end
      subject { coins.add(coin) }

      it 'increases a count of given coin' do
        expect { subject }.to change { coins.to_h }.to({ 1.0 => 1, 2.0 => 4 })
      end
    end

    context 'when a new coin' do
      let(:coin) { double(value: 2.0, count: 2) }
      let(:raw_coins) do
        {
          1.0 => 1
        }
      end
      subject { coins.add(coin) }

      it 'adds a new coin with given count' do
        expect { subject }.to change { coins.to_h }.to({ 1.0 => 1, 2.0 => 2 })
      end
    end
  end
end
