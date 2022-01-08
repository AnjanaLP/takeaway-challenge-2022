require 'takeaway'

describe Takeaway do
  subject(:takeaway)      { described_class.new(menu: menu, order: order) }
  let(:menu)              { double :menu }
  let(:order)             { double :order }

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
end
