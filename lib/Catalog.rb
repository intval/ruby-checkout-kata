module Shop

  class Catalog
    def initialize(items)
      @catalog = Hash.new
      items.each_entry {|item| @catalog[item.code.to_sym] = item}
    end

    def [](item_code)
      raise "Item with code #{item_code} not found in catalog" unless @catalog.has_key?(item_code)
      @catalog.fetch item_code.to_sym
    end
  end

end
