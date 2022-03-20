# frozen_string_literal: true

RSpec.describe VendingMachine::Money::Amount do
  let(:amount) { described_class.new(10.0) }
  let(:other) { described_class.new(20.0) }

  describe '#+' do
    subject { amount + other }

    it { is_expected.to be_a(described_class) }
    it { is_expected.to eq(30.0) }
  end

  describe '#-' do
    subject { amount - other }

    it { is_expected.to be_a(described_class) }
    it { is_expected.to eq(-10.0) }
  end

  describe '#*' do
    subject { amount * other }

    it { is_expected.to be_a(described_class) }
    it { is_expected.to eq(200.0) }
  end

  describe '#format' do
    subject { amount.format }

    it { is_expected.to eq("$10.00")}
  end
end
