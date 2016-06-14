module Shop
  class Checkout

    def initialize(pricing_rules = Array.new)
      @pricing_rules = Array.new
      @items = Array.new
      add_rules *pricing_rules
    end

    def scan(item)
      raise ArgumentError, 'Invalid item provided' unless item.respond_to? :price
      @items << item
    end

    def total
      sum = @items.reduce(0) { |sum, item| sum + item.price }
      discounts = @pricing_rules.reduce(0) do |total, rule|
        total + rule.get_discount(@items)
      end
      sum - discounts
    end

    def add_rules(*rules)
      @pricing_rules.concat rules
      @pricing_rules.sort_by! {|x| x.priority}
    end
  end
end