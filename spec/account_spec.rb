require 'account'

describe Account do
  let(:test_account) { Account.new }
  describe '#get_balance' do
    context 'starting account has £0.00 balance by default' do
      expected_output = "Account balance: £0.00."
      it { expect(test_account.see_balance).to eq expected_output }
    end
  end
end
