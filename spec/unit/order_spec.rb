require 'order'

describe Order do
  subject(:order)     { described_class.new(menu) }
  let(:menu)          { double :menu }

  describe '#add_to_basket' do
    before do
      allow(menu).to receive(:has?).with(:salad).and_return true
    end

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
      it 'does not add it to the basket' do
        allow(menu).to receive(:has?).with(:fries).and_return false
        order.add_to_basket(:fries, 3)
        expect(order.basket).not_to include(:fries)
      end
    end

    context 'when the given quantity is less than 1' do
      it 'does not add it to the basket' do
        order.add_to_basket(:salad, 0)
        expect(order.basket).not_to include(:salad)
      end
    end

    context 'when the given quantity is a decimal' do
      it 'rounds it the nearest whole number' do
        order.add_to_basket(:salad, 1.2)
        expect(order.basket).to include(salad: 1)
      end
    end
  end
end
