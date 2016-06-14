require 'rspec'
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
include Shop


describe 'Checkout' do

  before :all do

    @catalog = Catalog.new([
        Item.new(code: :FR1, name: 'Fruit tea', price: 3.11),
        Item.new(code: :AP1, name: 'Apple',     price: 5),
        Item.new(code: :CF1, name: 'Coffee',    price: 11.23)
    ])

    @rules = [
        BuyOneGetOneFree.new(:FR1, 1),
        BulkDiscountRule.new(:AP1, 3, 0.50, 2)
    ]

  end

  before :each do
    @checkout = Checkout.new(@rules)
  end

  it 'works for example basket #1' do
    %w{FR1 AP1 FR1 CF1}.each {|i| @checkout.scan(@catalog[i.to_sym]) }
    expect(@checkout.total).to eq(19.34)
    #assumed 22.45 is a mistake and rules should work together,
    # rather than cancel each other
    # If canceling was required, maybe a chain of command would be a more reasonable
    # structure for holding and iterating over rules

    # in this implementation, rules that contradict each other should be merged
    # ie, 2+1 free or 20% discount, the smallest between the two
  end

  it 'works for example basket #2' do
    [:FR1, :FR1].each {|i| @checkout.scan(@catalog[i]) }
    expect(@checkout.total).to eq(3.11)
  end

  it 'works for example basket #1' do
    [:AP1, :AP1, :FR1, :AP1].each {|i| @checkout.scan(@catalog[i]) }
    expect(@checkout.total).to eq(16.61)
  end
end