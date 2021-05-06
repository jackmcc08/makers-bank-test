require 'formatter_module'

describe Formatter do
  let(:test_record_1) { instance_double('Record',
                                        type: "deposit", amount: 2000, date: Date.new(2012, 1, 1), balance: 2000) }

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

  describe '#statement_format' do
    it 'formats a record object suitable for the bank statement' do
      input = test_record_1
      expected_output = "01/01/2012 || 2000.00 || || 2000.00"

      expect(statement_format(input)).to eq expected_output
    end
  end
 end
