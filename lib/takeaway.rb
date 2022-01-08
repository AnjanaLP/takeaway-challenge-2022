require_relative 'order'

class Takeaway

  def initialize(menu:, order: Order.new(menu))
    @menu = menu
    @order = order
  end

  def view_menu
    menu.display
  end

  def add(items)
    items.each { |name, quantity| order.add_to_basket(name, quantity) }
  end

  def correct_total?(total)
    raise "£#{'%.2f' % total} total entered does not match the £#{order_total} order total" unless equal_totals?(total)
    true
  end

  private

  attr_reader :menu, :order

  def equal_totals?(total)
    '%.2f' % total == order_total
  end

  def order_total
    '%.2f' % order.total
  end
end
