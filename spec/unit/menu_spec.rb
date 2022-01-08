require 'menu'

describe Menu do
  subject(:menu)      { described_class.new(items) }
  let(:items)         { { salad: 3.25, grilled_chicken: 4.75, sandwich: 7.5} }

  describe '#display' do
    it "displays each menu item's name with price in a readable format" do
      expect(menu.display).to eq "Salad: £3.25\nGrilled chicken: £4.75\nSandwich: £7.50"
    end
  end

  describe '#has?' do
    context 'when the item is on the menu' do
      it 'returns true' do
        expect(menu.has?(:salad)).to be true
      end
    end

    context 'when the item is not on the menu' do
      it 'returns false' do
        expect(menu.has?(:fries)).to be false
      end
    end 
  end
end
