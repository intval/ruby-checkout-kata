require 'rspec'
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
include Shop


describe 'Checkout' do

  coke = Item.new price:1, code: :coke, name: 'coke1'

  it 'calls all the rules' do

    mock = spy priority: 1, get_discount:1
    checkout = Checkout.new([mock, mock])
    checkout.scan coke
    checkout.total

    expect(mock).to have_received(:get_discount).with([coke]).twice
  end


  it 'honors priority' do

    rule10 = spy priority: 10, get_discount:1
    rule20 = spy priority: 20, get_discount:1
    rule30 = spy priority: 30, get_discount:1

    checkout = Checkout.new [rule30, rule20]
    checkout.add_rules rule10

    expected_calling_order = [rule10, rule20, rule30]
    actual_calling_order = []

    expected_calling_order.each do |spy|
      expect(spy).to receive(:get_discount) {actual_calling_order << spy; 1}
    end

    checkout.total

    expect(actual_calling_order).to eq expected_calling_order

  end

end