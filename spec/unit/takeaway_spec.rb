require 'takeaway'

describe Takeaway do
  subject(:takeaway)      { described_class.new(menu: menu, order: order) }
  let(:menu)              { double :menu }
  let(:order)             { double :order, total: 11 }

  describe '#view_menu' do
    it 'calls the display method on the menu' do
      expect(menu).to receive(:display)
      takeaway.view_menu
    end
  end

  describe '#add' do
    it 'calls the add_to_basket method on the order' do
      expect(order).to receive(:add_to_basket).twice
      takeaway.add(salad: 3, soup: 1)
    end
  end

  describe '#correct_total' do
    context 'when the given total matches the order total' do
      it 'returns true' do
        allow(order).to receive(:add_to_basket).twice
        takeaway.add(salad: 3, soup: 1)
        expect(takeaway.correct_total?(11)).to be true
      end
    end

    context 'when the given total does not match the order total' do
      it 'raises an error' do
        allow(order).to receive(:add_to_basket).twice
        takeaway.add(salad: 3, soup: 1)
        message = "£12.00 total entered does not match the £11.00 order total"
        expect { takeaway.correct_total?(12) }.to raise_error message
      end
    end
  end
end
