require 'account'

describe Account do
  let(:test_account) { Account.new }

  describe '#get_balance' do
    context 'starting account has £0.00 balance by default' do
      expected_output = "Account balance: £0.00."

      it { expect(test_account.see_balance).to eq expected_output }
    end

    context 'after depositing £1500' do
      expected_output = "Account balance: £1500.00."

      it {
        test_account.deposit(1500)
        expect(test_account.see_balance).to eq expected_output
      }
    end
  end

  describe '#deposit' do
    it 'allows you to depost a positive amount into your account' do
      input = 1500.00
      expected_output = "You have deposited £1500.00."

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

      expect(test_account.withdraw(input)).to eq expected_output
    end
  end
end
