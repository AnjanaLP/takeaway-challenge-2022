require 'order'

describe Order do
  subject(:order)     { described_class.new(menu) }
  let(:menu)          { double :menu }

  before { allow(menu).to receive(:has?).with(:salad).and_return true }

  describe '#add_to_basket' do
    it 'adds the given quantity of the given item to the basket' do
      order.add_to_basket(:salad, 3)
      expect(order.basket).to include(salad: 3)
    end

    context 'when the item is already in the basket' do
      it 'increments the quantity by the given amount' do
        order.add_to_basket(:salad, 3)
        order.add_to_basket(:salad, 2)
        expect(order.basket).to include(salad: 5)
      end
    end

    context 'when the item is not on the menu' do
      it 'raises an error' do
        item = :fries
        allow(menu).to receive(:has?).with(item).and_return false
        message = "Selected item #{item} is not on the menu. Please try again"
        expect { order.add_to_basket(item, 3) }.to raise_error message
      end
    end

    context 'when the given quantity is 0' do
      it 'raises an error' do
        quantity = 0
        message = "Quantity #{quantity} for salad is invalid. Please try again"
        expect { order.add_to_basket(:salad, quantity) }.to raise_error message
      end
    end

    context 'when the given quantity is negative' do
      it 'raises an error' do
        quantity = -3
        message = "Quantity #{quantity} for salad is invalid. Please try again"
        expect { order.add_to_basket(:salad, quantity) }.to raise_error message
      end
    end

    context 'when the given quantity is a decimal' do
      it 'raises an error' do
        quantity = 1.75
        message = "Quantity #{quantity} for salad is invalid. Please try again"
        expect { order.add_to_basket(:salad, quantity) }.to raise_error message
      end
    end

    context 'when the given quantity is not a number' do
      it 'raises an error' do
        quantity = "not a number"
        message = "Quantity #{quantity} for salad is invalid. Please try again"
        expect { order.add_to_basket(:salad, quantity) }.to raise_error message
      end
    end
  end

  describe '#total' do
    it 'returns the sum of all the items in the basket' do
      allow(menu).to receive(:has?).with(:sandwich).and_return true
      allow(menu).to receive(:price).with(:salad).and_return 3.25
      allow(menu).to receive(:price).with(:sandwich).and_return 7.50
      order.add_to_basket(:salad, 2)
      order.add_to_basket(:sandwich, 1)
      expect(order.total).to eq 14
    end
  end
end
