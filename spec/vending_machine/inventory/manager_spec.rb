# frozen_string_literal: true

RSpec.describe VendingMachine::Inventory::Manager do
  subject(:manager) { described_class.new(config) }

  describe '#quantity' do
    let(:config) do
      [
        { name: "Product 1", price: 1, quantity: 1 },
        { name: "Product 2", price: 2, quantity: 0 },
        { name: "Product 3", price: 3, quantity: 3 }
      ]
    end
    let(:product) do
      VendingMachine::Inventory::Product.new(name: 'Product 1', price: 1)
    end

    subject { manager.quantity(product) }

    it 'returns an quantity available of given product' do
      expect(subject).to eq(1)
    end
  end

  describe '#available?(product)' do
    let(:config) do
      [
        { name: "Product 1", price: 1, quantity: 1 },
        { name: "Product 2", price: 2, quantity: 0 },
        { name: "Product 3", price: 3, quantity: 3 }
      ]
    end

    subject { manager.available?(product) }

    context 'when product is in stock' do
      let(:product) do
        VendingMachine::Inventory::Product.new(name: 'Product 1', price: 1)
      end

      it { is_expected.to be true }
    end

    context 'when product is out of stock' do
      let(:product) do
        VendingMachine::Inventory::Product.new(name: 'Product 2', price: 2)
      end

      it { is_expected.to be false }
    end
  end

  describe '#draw' do
    let(:config) do
      [
        { name: "Product 1", price: 1, quantity: 1 },
        { name: "Product 2", price: 2, quantity: 0 },
        { name: "Product 3", price: 3, quantity: 3 }
      ]
    end
    let(:product) do
      VendingMachine::Inventory::Product.new(name: 'Product 1', price: 1)
    end

    subject { manager.draw(product) }

    it 'returns a given product' do
      expect(subject).to eq(product)
    end

    it "lowers product's quantity" do
      expect { subject }.to change { manager.quantity(product) }.by(-1)
    end
  end
end
