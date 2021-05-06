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
    records = @account.records
    result = ["date || credit || debit || balance"]

    records.reverse.each { |record| result.push(display_string(record)) }

    result.join("\n")
  end

  def set_date(year, month, day)
    check = date_error(year, month, day)
    return date_error_message(check) if check

    @account.set_date(year, month, day)
  end

  private

  def action_confirmation(amount, type)
    type_display = (type == "deposit" ? "deposited" : "withdrawn")
    "You have #{type_display} £#{format(amount)}."
  end

  def display_string(record)
    amount = (record.type == "deposit" ?
      " #{format(record.amount)} || " :
      " || #{format(record.amount)} ")

    "#{date_format(record.date)} ||#{amount}|| #{format(record.balance)}"
  end
end
