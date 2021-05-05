require 'account'

class BankTerminal
  def initialize(account = Account.new)
    @account = account
  end

  def deposit(amount)
    action = @account.deposit(amount)
    if action == "Success"
      action_confirmation(amount, "deposit")
    else
      error_message(action, "deposit")
    end
  end

  def withdraw(amount)
    action = @account.withdraw(amount)
    if action == "Success"
      action_confirmation(amount, "withdraw")
    else
      error_message(action, "withdraw")
    end
  end

  def display_balance
    amount = @account.balance
    "Account balance: £#{display(amount)}."
  end

  def display_statement
    records = @account.records
    result = ["date || credit || debit || balance"]
    return result[0] if records.empty?

    records.reverse.each do |entry|
      result.push(entry.display_string)
    end

    result.join("\n")
  end



  private

  def display(value)
    sprintf('%.2f', value)
  end

  def action_confirmation(amount, type)
    type_display = (type == "deposit" ? "deposited" : "withdrawn")
    "You have #{type_display} £#{display(amount)}."
  end

  def error_message(error_code, type)
    return "Incorrect input detected. Please #{type} a positive numeric value." if error_code == "FAIL:NAN"
    return "You cannot #{type} a negative amount." if error_code == "FAIL:NEG"
    return "You cannot #{type} a zero amount." if error_code == "FAIL:ZER"
    return "You do not have enough money in your account." if error_code == "FAIL:NEM"
  end


end
