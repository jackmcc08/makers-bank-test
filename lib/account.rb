require 'date'
require 'record'
require 'bank_terminal'

class Account
  def initialize(record_class = Record)
    @date = Date.new(2012, 1, 1)
    @balance = 0
    @record_class = record_class
    @records = []
  end

  def balance
    @balance
  end

  def records
    @records
  end

  def deposit(amount)
    type = "deposit"
    return error_code(amount) if input_invalid?(amount, type)

    record_action(amount, type)

    return "Success"
  end

  def withdraw(amount)
    type = "withdraw"
    return error_code(amount) if input_invalid?(amount, type)
    return "You do not have enough money in your account." unless enough_balance?(amount)

    record_action(amount, type)

    return "Success"
  end

  def set_date(year, month, day)
    @date = Date.new(year, month, day)
  end

  private

  def record_action(amount, type)
    balance_adjust = (type == "withdraw" ? amount * -1 : amount)
    @balance += balance_adjust

    @records << @record_class.new(amount, type, @date, @balance)
  end

  def enough_balance?(amount)
    @balance >= amount
  end

  def input_invalid?(value, _type)
    return true unless value.is_a? Numeric
    return true if value.negative?
    return true if value.zero?

    false
  end

  def error_code(value)
    return "FAIL:NAN" unless
    value.is_a? Numeric
    return "FAIL:NEG" if value.negative?
    return "FAIL:ZER" if value.zero?
  end
end
