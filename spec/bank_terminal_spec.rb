require 'bank_terminal'

describe BankTerminal do
  let(:test_terminal) { BankTerminal.new(account_double) }
  let(:account_double) { instance_double('Account') }
  let(:test_record_1) { instance_double('Record', display_string: "01/01/2012 || 2000.00 || || 2000.00") }
  let(:test_record_2) { instance_double('Record', display_string: "01/01/2012 || || 1000.00 || 1000.00") }

  describe '#display_statement' do
    it 'After one deposit and one withdrawal' do
      input_records = [
        test_record_1,
        test_record_2
      ]
      statement_two =
        %{date || credit || debit || balance\n01/01/2012 || || 1000.00 || 1000.00\n01/01/2012 || 2000.00 || || 2000.00}

      expect(test_terminal.display_statement(input_records)).to eq statement_two
    end

    it 'After one deposit' do
      input_records = [
        test_record_1
      ]
      statement_one =
        %{date || credit || debit || balance\n01/01/2012 || 2000.00 || || 2000.00}

      expect(test_terminal.display_statement(input_records)).to eq statement_one
    end

    it 'with no deposits or withdrawals' do
      input_records = []
      statement_zero = "date || credit || debit || balance"

      expect(test_terminal.display_statement(input_records)).to eq statement_zero
    end
  end


  describe '#display_balance' do
    it 'starting account has £0.00 balance by default' do
      expected_output = "Account balance: £0.00."
      allow(account_double).to receive(:see_balance).and_return(0)

      expect(test_terminal.display_balance).to eq expected_output
    end

    it 'after one deposit' do
      expected_output = "Account balance: £1500.00."
      allow(account_double).to receive(:see_balance).and_return(1500)

      expect(test_terminal.display_balance).to eq expected_output
    end

    it 'after one deposit and one withdraw' do
      expected_output = "Account balance: £1000.00."
      allow(account_double).to receive(:see_balance).and_return(1000)

      expect(test_terminal.display_balance).to eq expected_output
    end
  end

  describe '#deposit' do
    it 'allows you to deposit a positive amount into your account' do
      input = 1500.00
      expected_output = "You have deposited £1500.00."

      expect(test_terminal.deposit(input)).to eq expected_output
    end

    it 'does not allow you to deposit a negative amount' do
      input = -1500.00
      expected_output = "You cannot deposit a negative amount."

      expect(test_terminal.deposit(input)).to eq expected_output
    end
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
end
