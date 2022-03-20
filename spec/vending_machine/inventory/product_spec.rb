# frozen_string_literal: true

RSpec.describe VendingMachine::Inventory::Product do
  let(:name) { 'Some Product' }
  let(:price) { 2.50 }

  subject(:product) { described_class.new(name: name, price: price) }

  describe '#key' do
    subject { product.key }

    it 'returns a hash of a name' do
      expect(subject).to eq(name.hash)
    end
  end

  describe '#to_s' do
    subject { product.to_s }

    it 'returns a string with a product name and price' do
      expect(subject).to eq("Some Product ($2.50)")
    end
  end
end
