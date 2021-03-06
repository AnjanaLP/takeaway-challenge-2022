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
    takeaway.add(salad: 1, sandwich: 2)
    expect(takeaway.add(sandwich: 1)).to eq(salad: 1, sandwich: 3)
  end

  context 'when the customer selects a dish that is not on the menu' do
    it 'raises an error' do
      message = "Selected item fries is not on the menu. Please try again"
      expect { takeaway.add(fries: 1, sandwich: 2) }.to raise_error message
    end
  end

  context 'when the customer selects zero quantity' do
    it 'raises an error' do
      quantity = 0
      message = "Quantity #{quantity} for salad is invalid. Please try again"
      expect { takeaway.add(salad: quantity) }.to raise_error message
    end
  end

  context 'when the customer selects a negative quantity' do
    it 'raises an error' do
      quantity = -3
      message = "Quantity #{quantity} for salad is invalid. Please try again"
      expect { takeaway.add(salad: quantity) }.to raise_error message
    end
  end

  context 'when the customer selects a decimal quantity' do
    it 'raises an error' do
      quantity = 1.75
      message = "Quantity #{quantity} for salad is invalid. Please try again"
      expect { takeaway.add(salad: quantity) }.to raise_error message
    end
  end

  context 'when the customer selects a quantity which is not a number' do
    it 'raises an error' do
      quantity = "not a number"
      message = "Quantity #{quantity} for salad is invalid. Please try again"
      expect { takeaway.add(salad: quantity) }.to raise_error message
    end
  end

  # As a customer
  # So that I can verify that my order is correct
  # I would like to check that the total I have been given matches the sum of the various dishes in my order
  it 'a customer can check that the given total matches the sum of the dishes in their order' do
    takeaway.add(salad: 2, sandwich: 1)
    expect { takeaway.place_order(14) }.not_to raise_error
  end

  context 'when the total given by the customer does not match the order total' do
    it 'raises an error' do
      takeaway.add(salad: 2, sandwich: 1)
      message = "£12.00 total you entered does not match the £14.00 order total"
      expect { takeaway.place_order(12) }.to raise_error message
    end
  end

  # As a customer
  # So that I am reassured that my order will be delivered on time
  # I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered
  context 'when basket is empty' do
    it 'raises an error' do
     expect { takeaway.place_order(0) }.to raise_error "Cannot place order: basket is empty"
    end
  end

  it 'a customer receives a message with estimated delivery time after placing an order' do
    allow(Time).to receive(:now).and_return(Time.parse("17:52"))
    takeaway.add(salad: 2, sandwich: 1)
    expect(takeaway.place_order(14)).to eq "Thank you! Your order was placed and will be delivered before 18:52"
  end
end
