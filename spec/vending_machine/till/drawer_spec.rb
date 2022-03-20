# frozen_string_literal: true

RSpec.describe VendingMachine::Till::Drawer do
  let(:initial_coins) do
    {
      1.0 => 5,
      2.0 => 5,
      3.0 => 5,
      5.0 => 5
    }
  end

  subject(:drawer) { described_class.new(initial_coins) }

  describe '#prepare_change(amount)' do
    subject { drawer.prepare_change(amount) }

    context 'when amount is 0' do
      let(:amount) { 0.0 }

      it { is_expected.to be_empty }
    end

    context 'when amount is positive' do
      let(:amount) { 2.0 }

      it 'calls a change calculator' do
        calculated_change = double(:calculated_change)
        change_calculator = double(:change_calculator, call: calculated_change)

        allow(VendingMachine::Till::Change::Calculate)
          .to receive(:new)
          .with(coins: drawer.coins, amount: amount)
          .and_return(change_calculator)

        expect(subject).to eq(calculated_change)
      end
    end
  end

  describe '#draw(coins)' do
    let(:coins) do
      VendingMachine::Money::Coins.new({
        1.0 => 3,
        2.0 => 2,
        5.0 => 0
      })
    end

    subject { drawer.draw(coins) }

    it 'it removes given coins from the drawer' do
      expect { subject }
        .to change { drawer.coins.to_h }
        .to({
           1.0 => 2,
           2.0 => 3,
           3.0 => 5,
           5.0 => 5
        })
    end
  end

  describe '#store(coins)' do
    let(:coins) do
      VendingMachine::Money::Coins.new({
        1.0 => 2,
        2.0 => 3,
        4.0 => 1
      })
    end

    subject { drawer.store(coins) }

    it 'it adds given coins to the drawer' do
      expect { subject }
        .to change { drawer.coins.to_h }
        .to({
           1.0 => 7,
           2.0 => 8,
           3.0 => 5,
           4.0 => 1,
           5.0 => 5
         })
    end
  end
end
