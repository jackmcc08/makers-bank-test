require_relative './lib/bank_terminal'

USER = BankTerminal.new

puts "
Program autoloaded with a new user account - `USER`.

You can create your own variable name with `variable = BankTerminal.new`

Methods you can use with `USER`:
- `.deposit(1000)` - deposit cash into your account
- `.withdraw(1000)` - withdraw cash from your account -
    you need more money in your account than you are withdrawing
- `.set_date(2012, 12, 31)` - set the date on your account (year, month, day) -
    to adjust the date of your deposit and withdrawals
- `.display_balance` - displays your current balance
- `.display_statement` - displays your statement with all your actions, in reverse order -
    *note that you need to `puts` this method in order to see it nicely formatted*.

"
