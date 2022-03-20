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

  describe '#available_products' do
    let(:config) do
      [
        { name: "Product 1", price: 1, quantity: 1 },
        { name: "Product 2", price: 2, quantity: 0 },
        { name: "Product 3", price: 3, quantity: 3 }
      ]
    end

    subject { manager.available_products }

    it 'returns an array of Product objects' do
      expect(subject).to be_a(Array)
      expect(subject).to all(be_a(VendingMachine::Inventory::Product))
    end

    it 'returns only products with quantity > 0' do
      result = subject

      expect(result.length).to eq(2)
      expect(result[0].name).to eq('Product 1')
      expect(result[1].name).to eq('Product 3')
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
