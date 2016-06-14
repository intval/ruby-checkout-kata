require 'rspec'
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
include Shop


cola = Item.new code: :cola, price: 10, name: 'coke'
pepsi = Item.new code: :pepsi, price: 5, name: 'pepsi'

describe 'Rule.BuyOneGetOneFree' do

  it 'Give every 2nd item for free' do

    items = 11.times.map {cola}

    rule = BuyOneGetOneFree.new :cola, 10

    # 5 out of 11 gets discount
    expect(rule.get_discount items).to eq(5 * cola.price)

  end
end

describe 'Rule CheapestOfThreeFree' do

  it 'For every 3 items, the cheapest gets discounted' do

    items = [cola, cola, pepsi, pepsi]

    rule = CheapestOfThreeIsFree.new 1

    # one pepsi should be discounted as cheapest among 3 items
    expect(rule.get_discount items).to eq pepsi.price

  end

end



describe 'Rule BulkDiscount' do

  it 'gives discount for bulk' do

    items = [cola] * 10
    discount_size = 1

    rule = BulkDiscountRule.new :cola, 3, discount_size, 10

    # more than 3 cokes, hence should give 1$ discount on each
    expect(rule.get_discount items).to eq items.count*discount_size

  end

  it 'doesnt give discount for NON bulk' do

    items = [cola]

    rule = BulkDiscountRule.new :cola, 3, 1, 10

    # less than 3 cokes, no discount
    expect(rule.get_discount items).to eq 0

  end

end

