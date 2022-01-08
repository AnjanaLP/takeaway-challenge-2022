class Order

  def initialize(menu)
    @menu = menu
    @basket = Hash.new(0)
  end

  def add_to_basket(name, quantity)
    raise "Selected item #{name} is not on the menu. Please try again" unless on_the_menu?(name)
    raise "Quantity #{quantity} for #{name} is invalid. Please try again" unless valid?(quantity)
    @basket[name] += quantity
  end

  def basket
    @basket.dup
  end

  private

  attr_reader :menu

  def on_the_menu?(name)
    menu.has?(name)
  end

  def valid?(quantity)
    quantity.is_a?(Integer) && quantity.positive?
  end
end
