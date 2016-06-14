require 'rspec'

def flatten(arr)
  result = Array.new
  arr.each do |item|
    result.concat item.kind_of?(Array) ? flatten(item) : [item]
  end
  result
end

describe 'Flatten' do
  it 'should flatten nested arrays' do
    expect(flatten([])).to eq []
    expect(flatten([1])).to eq [1]
    expect(flatten([1,[2]])).to eq [1,2]
    expect(flatten([[[[[5]]]]])).to eq [5]
    expect(flatten([[[[[]]]]])).to eq []
    expect(flatten([[[[[5],6],7],8],9])).to eq [5,6,7,8,9]
    expect(flatten("some crap")).to eq ["somecrap"]
  end
end