require 'bank_terminal'

describe BankTerminal do
  let(:test_terminal) { BankTerminal.new(account_double) }
  let(:account_double) { instance_double('Account') }
  let(:test_record_1) { instance_double('Record',
                                        type: "deposit", amount: 2000, timestamp: Time.new(2012, 1, 1), balance: 2000)
  }
  let(:test_record_2) { instance_double('Record',
                                        type: "withdraw", amount: 1000, timestamp: Time.new(2012, 1, 1), balance: 1000)
  }

  describe '#display_statement' do
    it 'After one deposit and one withdrawal' do
      input_records = [
        test_record_2,
        test_record_1
      ]
      allow(account_double).to receive(:records_for_statement).and_return input_records

      statement_two =
        "date || credit || debit || balance\n"\
        "01/01/2012 || || 1000.00 || 1000.00\n"\
        "01/01/2012 || 2000.00 || || 2000.00"
      expected_output = statement_two

      expect(test_terminal.display_statement).to eq expected_output
    end

    it 'After one deposit' do
      input_records = [test_record_1]
      allow(account_double).to receive(:records_for_statement).and_return input_records

      statement_one =
        "date || credit || debit || balance\n"\
        "01/01/2012 || 2000.00 || || 2000.00"
      expected_output = statement_one

      expect(test_terminal.display_statement).to eq expected_output
    end

    it 'with no deposits or withdrawals' do
      input_records = []
      allow(account_double).to receive(:records_for_statement).and_return input_records

      statement_zero = "date || credit || debit || balance"
      expected_output = statement_zero

      expect(test_terminal.display_statement).to eq expected_output
    end
  end

  describe '#display_balance' do
    it 'starting account has £0.00 balance by default' do
      expected_output = "Account balance: £0.00."
      allow(account_double).to receive(:balance).and_return(0)

      expect(test_terminal.display_balance).to eq expected_output
    end

    it 'after one deposit' do
      expected_output = "Account balance: £1500.00."
      allow(account_double).to receive(:balance).and_return(1500)

      expect(test_terminal.display_balance).to eq expected_output
    end

    it 'after one deposit and one withdraw' do
      expected_output = "Account balance: £1000.00."
      allow(account_double).to receive(:balance).and_return(1000)

      expect(test_terminal.display_balance).to eq expected_output
    end
  end

  describe '#deposit' do
    it 'allows you to deposit a positive amount into your account' do
      input = 1500.00
      allow(account_double).to receive(:deposit)

      expected_output = "You have deposited £1500.00."

      expect(test_terminal.deposit(input)).to eq expected_output
    end

    it 'does not allow you to deposit a negative amount' do
      input = -1500.00
      expected_output = "You cannot deposit a negative amount."

      expect { test_terminal.deposit(input) }.to raise_error expected_output
    end

    it 'does not allow you to deposit a zero amount' do
      input = 0
      expected_output = "You cannot deposit a zero amount."

      expect { test_terminal.deposit(input) }.to raise_error expected_output
    end

    it 'rejects a non-numeric input amount' do
      input = "100"
      expected_output = "Incorrect input detected. Please deposit a numeric value."

      expect { test_terminal.deposit(input) }.to raise_error expected_output

      input = ['111']
      expect { test_terminal.deposit(input) }.to raise_error expected_output
    end
  end

  describe '#withdraw' do
    it 'allows you to withdraw money from your account' do
      input = 500
      allow(account_double).to receive(:withdraw)

      expected_output = "You have withdrawn £500.00."

      expect(test_terminal.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw a negative amount' do
      input = -10
      expected_output = "You cannot withdraw a negative amount."

      expect { test_terminal.withdraw(input) }.to raise_error expected_output
    end

    it 'does not allow you to withdraw a zero amount' do
      input = 0
      expected_output = "You cannot withdraw a zero amount."

      expect { test_terminal.withdraw(input) }.to raise_error expected_output
    end

    it 'rejects a non-numeric input amount' do
      input = "100"
      expected_output = "Incorrect input detected. Please withdraw a numeric value."

      expect { test_terminal.withdraw(input) }.to raise_error expected_output

      input = ['111']
      expect { test_terminal.withdraw(input) }.to raise_error expected_output
    end
  end
end
