require 'record'

describe Record do
  before do
    amount_input = 1000
    type_input = "deposit"
    type_input_2 = "withdraw"
    date_input = Date.new(2012, 1, 1)
    balance_input = 1000

    @test_record = Record.new(amount_input, type_input, date_input, balance_input)
    @test_record_2 = Record.new(amount_input, type_input_2, date_input, balance_input)
  end

  describe '#new' do
    it 'creates a record object with the appropriate input' do
      expect(@test_record).to be_instance_of Record
    end
  end

  describe '#display_record' do
    it 'provides a string for display in the statement for deposits' do
      expected_output = "01/01/2012 || 1000.00 || || 1000.00"

      expect(@test_record.display_string).to eq expected_output
    end

    it 'provides a string for display in the statement for withdrawals' do
      expected_output = "01/01/2012 || || 1000.00 || 1000.00"

      expect(@test_record_2.display_string).to eq expected_output
    end
  end
end
