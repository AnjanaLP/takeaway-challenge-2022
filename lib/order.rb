class Order

  def initialize(menu)
    @menu = menu
    @basket = Hash.new(0)
  end

  def add_to_basket(name, quantity)
    @basket[name] += quantity.round if valid_request?(name, quantity)
  end

  def basket
    @basket.dup
  end

  private

  attr_reader :menu

  def valid_request?(name, quantity)
    menu.has?(name) && quantity >= 1
  end
end
