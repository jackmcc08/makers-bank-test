require 'bank_terminal'

describe BankTerminal do
  let(:test_terminal) { BankTerminal.new }
  let(:test_record_1) { instance_double('Record', display_string: "01/01/2012 || 2000.00 || || 2000.00")}
  let(:test_record_2) { instance_double('Record', display_string: "01/01/2012 || || 1000.00 || 1000.00")}


  describe '#display_statement' do
    it 'After one deposit and one withdrawal' do
      input_records = [
        test_record_1,
        test_record_2
      ]

      expect(test_terminal.display_statement(input_records)).to eq STATEMENT_TWO
    end

    it 'After one deposit' do
      input_records = [
        test_record_1
      ]

      expect(test_terminal.display_statement(input_records)).to eq STATEMENT_ONE
    end

    it 'with no deposits or withdrawals' do
      input_records = []

      expect(test_terminal.display_statement(input_records)).to eq STATEMENT_ZERO
    end

    STATEMENT_ZERO = "date || credit || debit || balance"

    STATEMENT_ONE =
      %{date || credit || debit || balance\n01/01/2012 || 2000.00 || || 2000.00}

    STATEMENT_TWO =
      %{date || credit || debit || balance\n01/01/2012 || || 1000.00 || 1000.00\n01/01/2012 || 2000.00 || || 2000.00}
  end
end
