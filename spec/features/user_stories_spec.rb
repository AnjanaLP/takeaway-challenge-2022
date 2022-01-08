describe 'User Stories' do

  # As a customer
  # So that I can check if I want to order something
  # I would like to see a list of dishes with prices
  it 'a customer can see a list of dishes with prices' do
     items = { salad: 3.25, grilled_chicken: 4.75, sandwich: 7.5 }
     menu = Menu.new(items)
     takeaway = Takeaway.new(menu: menu)
     expect(takeaway.view_menu).to eq "Salad: £3.25\nGrilled chicken: £4.75\nSandwich: £7.50"
  end
end
