require 'date'

class Account
  def initialize(record_class = Record)
    @date = Date.new(2012,1,1)
    @balance = 0
    @record_class = record_class
    @records = []
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def statement
    result = ["date || credit || debit || balance"]
    return result[0] if @records.empty?

    @records.reverse.each { |entry| result << entry.display_string }

    result.join("\n")
  end

  def deposit(amount)
    return invalid_message(amount, "deposit") if input_invalid?(amount, "deposit")

    record_action(amount, "deposit")

    "You have deposited £#{display(amount)}."
  end

  def withdraw(amount)
    return invalid_message(amount, "withdraw") if input_invalid?(amount, "withdraw")
    return "You do not have enough money in your account." unless enough_balance?(amount)

    record_action(amount, "withdraw")

    "You have withdrawn £#{display(amount)}."
  end

  def set_date(year, month, day)
    @date = Date.new(year, month, day)
  end

  private

  def display(value)
    sprintf('%.2f', value)
  end

  def record_action(amount, type)
    balance_adjust = (type == "withdraw" ? amount * -1 : amount)
    @balance += balance_adjust

    @records << @record_class.new(amount, type, @date, @balance)
  end

  def enough_balance?(amount)
    @balance >= amount
  end

  def input_invalid?(value, type)
    return true unless value.is_a? Numeric
    return true if value.negative?
    return true if value.zero?

    false
  end

  def invalid_message(value, type)
    return "Incorrect input detected. Please #{type} a positive numeric value." unless
    value.is_a? Numeric
    return "You cannot #{type} a negative amount." if value.negative?
    return "You cannot #{type} a zero amount." if value.zero?
  end
end
