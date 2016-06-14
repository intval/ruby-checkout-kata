module Shop
  class Item
    attr_reader :code, :name, :price
    def initialize(code:, name:, price:)

      # todo, should check anything ?
      # raise ArgumentError, 'code cannot be empty' unless code.is

      @code = code
      @name = name
      @price = price
    end
  end
end