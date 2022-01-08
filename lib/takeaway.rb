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

  def place_order(customer_total)
    correct_total?(customer_total)
    return standard_message if sms_unavailable?
    sms.send_text
  end

  private

  attr_reader :menu, :order, :sms

  def equal_totals?(customer_total)
    customer_total == order.total
  end

  def correct_total?(customer_total)
    message = "£#{'%.2f' % customer_total} total you entered does not match the £#{'%.2f' % order.total} order total"
    raise message unless equal_totals?(customer_total)
  end

  def sms_unavailable?
    sms.nil?
  end

  def standard_message
    "Thank you! Your order was placed and will be delivered before #{(Time.now + 60*60).strftime("%H:%M")}"
  end
end
