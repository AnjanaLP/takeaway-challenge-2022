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
    items.each do |name, quantity|
      order.add_to_basket(name, quantity)
    end
  end

  private

  attr_reader :menu, :order
end
