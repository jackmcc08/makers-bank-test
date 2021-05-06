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

  describe '#date_format' do
    it 'formats a date object to dd/mm/yyyy' do
      input = Date.new(2012, 1, 1)
      expected_output = '01/01/2012'

      expect(date_format(input)).to eq expected_output
    end
  end
end
