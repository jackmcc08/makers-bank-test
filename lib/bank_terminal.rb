require_relative 'account'

class BankTerminal
  def initialize(account = Account.new)
    @account = account
  end

  def deposit(amount)
    action = @account.deposit(amount)
    return action_confirmation(amount, "deposit") if action == "Success"

    error_message(action, "deposit")
  end

  def withdraw(amount)
    action = @account.withdraw(amount)
    return action_confirmation(amount, "withdraw") if action == "Success"

    error_message(action, "withdraw")
  end

  def display_balance
    "Account balance: £#{format(@account.balance)}."
  end

  def display_statement
    records = @account.records
    result = ["date || credit || debit || balance"]
    return result[0] if records.empty?

    records.reverse.each { |entry| result.push(entry.display_string) }

    result.join("\n")
  end

  def set_date(year, month, day)
    check = date_error(year, month, day)
    return date_error_message(check) if check

    @account.set_date(year, month, day)
  end

  private

  def format(value)
    sprintf('%.2f', value)
  end

  def action_confirmation(amount, type)
    type_display = (type == "deposit" ? "deposited" : "withdrawn")
    "You have #{type_display} £#{format(amount)}."
  end

  def error_message(code, type)
    return "Incorrect input detected. Please #{type} a numeric value." if
    code == "FAIL:NAN"
    return "You cannot #{type} a negative amount." if code == "FAIL:NEG"
    return "You cannot #{type} a zero amount." if code == "FAIL:ZER"
    return "You do not have enough money in your account." if code == "FAIL:NEM"
  end

  def date_error(year, month, day)
    return "FAIL:D_YR" unless year.digits.count == 4
    return "FAIL:D_MO" unless month.digits.count == 1 || month.digits.count == 2
    return "FAIL:D_DY" unless day.digits.count == 1 || day.digits.count == 2

    false
  end

  def date_error_message(code)
    return "Year must be an 4 digit integer." if code == "FAIL:D_YR"
    return "Month must be a 1 or 2 digit integer." if code == "FAIL:D_MO"
    return "Day must be a 1 or 2 digit integer." if code == "FAIL:D_DY"
  end

end
