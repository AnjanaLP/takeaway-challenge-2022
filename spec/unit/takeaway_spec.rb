require 'takeaway'

describe Takeaway do
  subject(:takeaway)      { described_class.new(menu: menu, order: order, sms: sms) }
  let(:menu)              { double :menu }
  let(:order)             { double :order, total: 11, add_to_basket: nil, basket: { salad: 3, soup: 1 } }
  let(:sms)               { double :sms }

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

  describe '#place_order' do
    context 'when basket is empty' do
      it 'raises an error' do
        allow(order).to receive(:basket).and_return(Hash.new(0))
        expect { takeaway.place_order(0) }.to raise_error "Cannot place order: basket is empty"
      end
    end

    context 'when basket is not empty' do
      before { takeaway.add(salad: 3, soup: 1) }

      context 'when the total given by the customer does not match the order total' do
        it 'raises an error' do
          message = "£12.00 total you entered does not match the £11.00 order total"
          expect { takeaway.place_order(12) }.to raise_error message
        end
      end

      context 'when a confirmation message can be sent via sms' do
        it 'calls the send_text method on the sms' do
          expect(sms).to receive(:send_text)
          takeaway.place_order(11)
        end
      end

      context 'when a confirmation message cannot be sent via sms' do
        subject(:takeaway)      { described_class.new(menu: menu, sms: nil, order: order) }
        it 'returns the message as a string' do
          allow(Time).to receive(:now).and_return(Time.parse("17:52"))
          message = "Thank you! Your order was placed and will be delivered before 18:52"
          expect(takeaway.place_order(11)).to eq message
        end
      end
    end
  end
end
