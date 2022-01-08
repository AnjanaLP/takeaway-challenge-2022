require 'takeaway'

describe Takeaway do
  subject(:takeaway)      { described_class.new(menu: menu) }
  let(:menu)              { double :menu }

  it 'calls the display method on the menu' do
    expect(menu).to receive(:display)
    takeaway.view_menu
  end
end
