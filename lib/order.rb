class Order

  def initialize(menu)
    @menu = menu
    @basket = Hash.new(0)
  end

  def add_to_basket(name, quantity)
    @basket[name] += absolute_value(quantity) if on_the_menu?(name)
  end

  def basket
    @basket.dup
  end

  private

  attr_reader :menu
  
  def on_the_menu?(name)
    menu.has?(name)
  end

  def absolute_value(quantity)
    quantity.abs
  end
end
