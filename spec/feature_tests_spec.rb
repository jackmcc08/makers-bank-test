require 'bank_terminal'
require 'timecop'

describe 'Feature Test 1' do
  context 'a user deposits £1000 and withdraws £150.50, statement' do
    it {
      user = BankTerminal.new
      Timecop.freeze(2012, 1, 1)
      user.deposit(1000)
      Timecop.freeze(2012, 1, 3)
      user.withdraw(150.50)

      expected_output = "date || credit || debit || balance\n"\
      "03/01/2012 || || 150.50 || 849.50\n"\
      "01/01/2012 || 1000.00 || || 1000.00"
      expect(user.display_statement).to eq expected_output
    }
  end
end

describe 'Feature Test 2' do
  context 'a user deposits £1000 and withdraws £150.50, statement' do
    it {
      user = BankTerminal.new
      Timecop.freeze(2012, 1, 10)
      user.deposit(1000)
      Timecop.freeze(2012, 1, 13)
      user.deposit(2000)
      Timecop.freeze(2012, 1, 14)
      user.withdraw(500)

      expected_output = "date || credit || debit || balance\n"\
        "14/01/2012 || || 500.00 || 2500.00\n"\
        "13/01/2012 || 2000.00 || || 3000.00\n"\
        "10/01/2012 || 1000.00 || || 1000.00"
      expect(user.display_statement).to eq expected_output
    }
  end
end
