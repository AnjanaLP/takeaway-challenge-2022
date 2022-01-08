require_relative 'order'

class Takeaway

  def initialize(menu:, order: Order.new(menu), sms: nil)
    @menu = menu
    @order = order
    @sms = sms
  end

  def view_menu
    menu.display
  end

  def add(items)
    items.each { |name, quantity| order.add_to_basket(name, quantity) }
    order.basket
  end

  def place_order(total)
    verify_basket_not_empty
    verify_correct_total(total)
    send_message
  end

  private

  attr_reader :menu, :order, :sms

  def verify_basket_not_empty
    raise "Cannot place order: basket is empty" if order.basket.empty?
  end

  def verify_correct_total(total)
    message = "£#{'%.2f' % total} total you entered does not match the £#{'%.2f' % order.total} order total"
    raise message unless total == order.total
  end

  def send_message
    sms.nil? ? standard_message : sms.send_text
  end

  def standard_message
    "Thank you! Your order was placed and will be delivered before #{(Time.now + 60*60).strftime("%H:%M")}"
  end
end
