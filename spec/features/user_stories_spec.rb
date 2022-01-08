describe 'User Stories' do
  let(:takeaway)      { Takeaway.new(menu: menu, order: order) }
  let(:menu)          { Menu.new(items) }
  let(:order)         { Order.new(menu) }
  let(:items)         { { salad: 3.25, grilled_chicken: 4.75, sandwich: 7.5 } }

  # As a customer
  # So that I can check if I want to order something
  # I would like to see a list of dishes with prices
  it 'a customer can see a list of dishes with prices' do
    printed_menu = "Salad: £3.25\nGrilled chicken: £4.75\nSandwich: £7.50"
    expect(takeaway.view_menu).to eq printed_menu
  end

  # As a customer
  # So that I can order the meal I want
  # I would like to be able to select some number of several available dishes
  it 'a customer can select some number of several available dishes' do
    takeaway.add(fries: 3, salad: -1, sandwich: 2, grilled_chicken: 0)
    takeaway.add(sandwich: 1.2)
    expect(order.basket).to eq(sandwich: 3)
  end
end
