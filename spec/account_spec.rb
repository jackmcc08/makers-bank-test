require 'account'

describe Account do
  let(:test_account) { Account.new(test_record_class) }
  let(:test_record) { instance_double("Record") }
  let(:test_record_class) { class_double("Record", new: test_record) }

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
        allow(test_record).to receive(:balance).and_return(1500, 1000)
        test_account.withdraw(500)

        expect(test_account.balance).to eq expected_output
      }
    end
  end

  describe '#records' do
    context 'with no deposits or withdrawals' do
      expected_output = []

      it { expect(test_account.records).to eq expected_output }
    end

    context 'After one deposit' do
      it {
        expected_output = [test_record]
        test_account.deposit(1500)

        expect(test_account.records).to eq expected_output
      }
    end

    context 'After one deposit and one withdrawal' do
      it {
        expected_output = [test_record, test_record]
        test_account.deposit(1500)
        allow(test_record).to receive(:balance).and_return(1500)
        test_account.withdraw(500)

        expect(test_account.records).to eq expected_output
      }
    end
  end

  describe '#deposit' do
    it 'allows you to deposit a positive amount into your account' do
      input = 1500.00
      expected_output = "Success"

      expect(test_account.deposit(input)).to eq expected_output
    end

    it 'does not allow you to deposit a negative amount' do
      input = -1500.00
      expected_output = "FAIL:NEG"

      expect(test_account.deposit(input)).to eq expected_output
    end

    it 'does not allow you to deposit a zero amount' do
      input = 0
      expected_output = "FAIL:ZER"

      expect(test_account.deposit(input)).to eq expected_output
    end

    it 'rejects a non-numeric input amount' do
      input = "100"
      expected_output = "FAIL:NAN"

      expect(test_account.deposit(input)).to eq expected_output

      input = ['111']
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
      expected_output = "Success"

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw money if it will take your balance negative or your account is negative' do
      input = 2500
      expected_output = "FAIL:NEM"

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw a negative amount' do
      input = -10
      expected_output = "FAIL:NEG"

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'does not allow you to withdraw a zero amount' do
      input = 0
      expected_output = "FAIL:ZER"

      expect(test_account.withdraw(input)).to eq expected_output
    end

    it 'rejects a non-numeric input amount' do
      input = "100"
      expected_output = "FAIL:NAN"

      expect(test_account.withdraw(input)).to eq expected_output

      input = ['111']
      expect(test_account.withdraw(input)).to eq expected_output
    end
  end
  # 
  # describe '#set_date' do
  #   it 'sets the date on the account' do
  #     expect(test_account.set_date(2012, 1, 1)).to be_instance_of Date
  #   end
  # end
end
