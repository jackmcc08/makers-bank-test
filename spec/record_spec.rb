require 'record'

describe Record do
  let(:test_recorder) { Record.new }

  describe '#new' do
    it 'creates a record object with the appropriate input' do
      amount_input = 1000
      type_input = "deposit"
      date_input = "01/01/2012"
      balance_input = 1000

      test_record = Record.new(amount_input, type_input, date_input, balance_input)

      expect(test_record).to be_instance_of Record
    end
  end
end
