class Menu

  def initialize(items)
   @items = items
  end

  def display
   items.map do |name, price|
     "#{format_name(name)}: £#{format_price(price)}"
   end.join("\n")
  end

  def has?(item)
    !items[item].nil?
  end

  def price(name)
    items[name]
  end

  private

  attr_reader :items

  def format_name(name)
   name.capitalize.to_s.gsub("_", " ")
  end

  def format_price(price)
   '%.2f' % price
  end
end
