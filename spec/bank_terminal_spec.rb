require 'bank_terminal'

describe BankTerminal do
  let(:test_terminal) { BankTerminal.new }
  let(:test_record_1) { instance_double('Record', display_string: "01/01/2012 || 2000.00 || || 2000.00") }
  let(:test_record_2) { instance_double('Record', display_string: "01/01/2012 || || 1000.00 || 1000.00") }

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

  describe '#action_confirmation' do
    it 'provides a confirmation of deposit' do
      expected_output = "You have deposited £1000.00."

      expect(test_terminal.action_confirmation(1000, "deposit")).to eq expected_output
    end

    it 'provides confirmation of withdraw' do
      expected_output = "You have withdrawn £1000.00."

      expect(test_terminal.action_confirmation(1000, "withdraw")).to eq expected_output
    end
  end

  describe '#display_balance' do
    it 'after one deposit' do
      expected_output = "Account balance: £1500.00."

      expect(test_terminal.display_balance(1500)).to eq expected_output
    end
  end
end
