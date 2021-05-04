require 'account'

describe Account do
  let(:test_account) { Account.new(test_record_class, test_terminal) }
  let(:test_record) { instance_double("Record") }
  let(:test_record_class) { class_double("Record", new: test_record) }
  let(:test_terminal) { instance_double('Terminal', action_confirmation: "") }

  describe '#see_balance' do
    context 'starting account has £0.00 balance by default' do
      expected_output = "Account balance: £0.00."

      it {
        allow(test_terminal).to receive(:display_balance).and_return "Account balance: £0.00."
        expect(test_account.see_balance).to eq expected_output
      }
    end

    context 'after depositing £1500' do
      expected_output = "Account balance: £1500.00."

      it {
        allow(test_terminal).to receive(:display_balance).and_return "Account balance: £1500.00."

        expect(test_account.see_balance).to eq expected_output
      }
    end

    context 'after depositing £1500 and withdrawing £500' do
      expected_output = "Account balance: £1000.00."

      it {
        allow(test_terminal).to receive(:display_balance).and_return "Account balance: £1000.00."

        expect(test_account.see_balance).to eq expected_output
      }
    end
  end

  describe '#deposit' do
    it 'allows you to depost a positive amount into your account' do
      input = 1500.00
      expected_output = "You have deposited £1500.00."
      allow(test_terminal).to receive(:action_confirmation).and_return "You have deposited £1500.00."

      expect(test_account.deposit(input)).to eq expected_output
    end

    it 'does not allow you to deposit a negative amount' do
      input = -1500.00
      expected_output = "You cannot deposit a negative amount."

      expect(test_account.deposit(input)).to eq expected_output
    end

    it 'does not allow you to deposit a zero amount' do
      input = 0
      expected_output = "You cannot deposit a zero amount."

      expect(test_account.deposit(input)).to eq expected_output
    end

    it 'rejects a non-numeric input amount' do
      input = "100"
      expected_output = "Incorrect input detected. Please deposit a positive numeric value."

      expect(test_account.deposit(input)).to eq expected_output

      input = ['111']
      expect(test_account.deposit(input)).to eq expected_output
    end
  end

  describe '#withdraw' do
    before do
      test_account.deposit(2000)
    end

    it 'allows you to withdraw money from your account' do
      input = 500
      expected_output = "You have withdrawn £500.00."

      allow(test_terminal).to receive(:action_confirmation).and_return "You have withdrawn £500.00."

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw money if it will take your balance negative or your account is negative' do
      input = 2500
      expected_output = "You do not have enough money in your account."

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw a negative amount' do
      input = -10
      expected_output = "You cannot withdraw a negative amount."

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw a zero amount' do
      input = 0
      expected_output = "You cannot withdraw a zero amount."

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'rejects a non-numeric input amount' do
      input = "100"
      expected_output = "Incorrect input detected. Please withdraw a positive numeric value."

      expect(test_account.withdraw(input)).to eq expected_output

      input = ['111']
      expect(test_account.withdraw(input)).to eq expected_output
    end
  end

  describe '#statement' do
    @statement_zero = "date || credit || debit || balance"

    @statement_one =
      %{date || credit || debit || balance\n01/01/2012 || 2000.00 || || 2000.00}

    @statement_two =
      %{date || credit || debit || balance\n01/01/2012 || || 1000.00 || 1000.00\n01/01/2012 || 2000.00 || || 2000.00}

    context 'with no deposits or withdrawals' do
      expected_output = @statement_zero

      it {
        allow(test_terminal).to receive(:display_statement).and_return @statement_zero

        expect(test_account.statement).to eq expected_output
      }
    end

    context 'After one deposit' do
      expected_output = @statement_one

      it {
        allow(test_terminal).to receive(:display_statement).and_return @statement_one

        expect(test_account.statement).to eq expected_output
      }
    end

    context 'After one deposit and one withdrawal' do
      expected_output = @statement_two

      it {
        allow(test_terminal).to receive(:display_statement).and_return @statement_two

        expect(test_account.statement).to eq expected_output
      }
    end
  end

  describe '#set_date' do
    it 'sets the date on the account' do
      expect(test_account.set_date(2012, 1, 1)).to be_instance_of Date
    end
  end
end
