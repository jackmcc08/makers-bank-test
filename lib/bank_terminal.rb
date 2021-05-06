require_relative 'account'
require_relative 'error_module'
require_relative 'formatter_module'

class BankTerminal
  def initialize(account = Account.new)
    @account = account
  end

  include ErrorManager, Formatter

  def deposit(amount)
    action = @account.deposit(amount)
    return action_confirmation(amount, "deposit") if action == "Success"

    input_error_message(action, "deposit")
  end

  def withdraw(amount)
    action = @account.withdraw(amount)
    return action_confirmation(amount, "withdraw") if action == "Success"

    input_error_message(action, "withdraw")
  end

  def display_balance
    "Account balance: £#{format(@account.balance)}."
  end

  def display_statement
    statement_format(@account.records_for_statement)
  end

  private

  def action_confirmation(amount, type)
    type_display = (type == "deposit" ? "deposited" : "withdrawn")
    "You have #{type_display} £#{format(amount)}."
  end
end
