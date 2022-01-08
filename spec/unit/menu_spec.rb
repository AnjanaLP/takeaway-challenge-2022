require 'menu'

describe Menu do
  subject(:menu)      { described_class.new(items) }
  let(:items)         { { salad: 3.25, grilled_chicken: 4.75, sandwich: 7.5} }

  it "displays each menu item's name with price in a readable format" do
   expect(menu.display).to eq "Salad: £3.25\nGrilled chicken: £4.75\nSandwich: £7.50"
  end
end
