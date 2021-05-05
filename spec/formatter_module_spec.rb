require 'formatter_module'

describe Formatter do
  include Formatter
  
  describe '#format' do
    it 'formats a value to 2 decimal places as a string' do
      input = 5
      expected_output = '5.00'

      expect(format(input)).to eq expected_output
    end
  end
end
