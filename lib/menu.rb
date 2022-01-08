class Menu

  def initialize(items)
   @items = items
  end

  def display
   items.map { |name, price| format(name, price) }.join("\n")
  end

  def has?(item)
    !items[item].nil?
  end

  def price(name)
    items[name]
  end

  private

  attr_reader :items

  def format(name, price)
    "#{name.capitalize.to_s.gsub("_", " ")}: £#{'%.2f' % price}"
  end
end
