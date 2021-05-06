require 'account'

describe Account do
  let(:test_account) { Account.new(test_record_class) }
  let(:test_record) { instance_double("Record") }
  let(:test_record_2) { instance_double("Record") }
  let(:test_record_class) { class_double("Record") }

  before do
    allow(test_record_class).to receive(:new).and_return(test_record, test_record_2)
  end

  describe '#balance' do
    context 'starting account has £0.00 balance by default' do
      expected_output = 0

      it { expect(test_account.balance).to eq expected_output }
    end

    context 'after depositing £1500' do
      expected_output = 1500

      it {
        test_account.deposit(1500)
        allow(test_record).to receive(:balance).and_return(1500)

        expect(test_account.balance).to eq expected_output
      }
    end

    context 'after depositing £1500 and withdrawing £500' do
      expected_output = 1000

      it {
        test_account.deposit(1500)
        allow(test_record).to receive(:balance).and_return(1500)
        test_account.withdraw(500)
        allow(test_record_2).to receive(:balance).and_return(1000)

        expect(test_account.balance).to eq expected_output
      }
    end
  end

  describe '#records_for_statement' do
    it 'provides the records data in the correct logic for the statement' do
      test_account.deposit(1500)
      allow(test_record).to receive(:balance).and_return(1500)
      test_account.deposit(1500)
      expected_output = [test_record_2, test_record]

      expect(test_account.records_for_statement).to eq expected_output
    end
  end

  describe '#records_for_statement' do
    context 'with no deposits or withdrawals' do
      expected_output = []

      it { expect(test_account.records_for_statement).to eq expected_output }
    end

    context 'After one deposit' do
      it {
        expected_output = [test_record]
        test_account.deposit(1500)

        expect(test_account.records_for_statement).to eq expected_output
      }
    end

    context 'After one deposit and one withdrawal' do
      it {
        expected_output = [test_record_2, test_record]
        test_account.deposit(1500)
        allow(test_record).to receive(:balance).and_return(1500)
        test_account.withdraw(500)

        expect(test_account.records_for_statement).to eq expected_output
      }
    end
  end

  describe '#deposit' do
    it 'allows you to deposit a positive amount into your account' do
      input = 1500.00
      expected_output = test_record

      expect(test_account.deposit(input)).to eq expected_output
    end
  end

  describe '#withdraw' do
    before do
      test_account.deposit(2000)
      allow(test_record).to receive(:balance).and_return(2000)
    end

    it 'allows you to withdraw money from your account' do
      input = 500
      expected_output = test_record_2

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw money if it will take your balance negative or your account is negative' do
      input = 2500
      expected_output = "You do not have enough money in your account."

      expect { test_account.withdraw(input) }.to raise_error  expected_output
    end
  end
end
