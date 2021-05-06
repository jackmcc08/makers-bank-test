require 'record'

describe Record do
  before do
    amount_input = 1000
    type_input = "deposit"
    type_input_2 = "withdraw"
    balance_input = 1000

    @test_record = Record.new(amount_input, type_input, balance_input)
    @test_record_2 = Record.new(amount_input, type_input_2, balance_input)
  end

  describe '#new' do
    it 'creates a record object with the appropriate input' do
      expect(@test_record).to be_instance_of Record
    end
  end
end
