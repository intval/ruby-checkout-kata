module Shop

  class Rule

    attr_reader :priority

    def initialize(priority = 0)
      @priority = priority
    end

    def get_discount(items, intermediate_total)
      raise NotImplementedError
    end
  end



  class BuyOneGetOneFree < Rule

    def initialize(item_code, priority)
      @item_code = item_code
      super priority
    end

    def get_discount(items)
      items_of_type = items.each.select {|x| x.code == @item_code}
      items_of_type.count / 2 * items_of_type.first.price
    end
  end



  class BulkDiscountRule < Rule

    def initialize(item_code, bulk_amount, discount_per_item, priority)
      @item_code = item_code
      @bulk_amount = bulk_amount
      @discount_per_item = discount_per_item
      super priority
    end

    def get_discount(items)
      items_of_type = items.count {|x| x.code == @item_code}
      items_of_type >= @bulk_amount ? @discount_per_item * items_of_type : 0
    end
  end




  class CheapestOfThreeIsFree < Rule
    #todo, perhaps add groups,
    #such as cheapest of 3 among apples, bananas and oranges

    def get_discount(items)
      items
          .sort_by { |x| x.price }
          .slice(0, items.length / 3)
          .inject(0){|sum, item| sum + item.price}
    end
  end
end
