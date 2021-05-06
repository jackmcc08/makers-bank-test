require 'date'
require_relative 'record'
require_relative 'error_module'

class Account
  def initialize(record_class = Record)
    # @date = Date.new(2012, 1, 1)
    @record_class = record_class
    @records = []
  end

  attr_reader :records

  include ErrorManager

  def balance
    @records.empty? ? 0 : @records.last.balance
  end

  def deposit(amount)
    type = "deposit"
    error_code = input_invalid(amount, type)
    return error_code if error_code

    record_action(amount, type)
    return "Success"
  end

  def withdraw(amount)
    type = "withdraw"
    error_code = input_invalid(amount, type)
    return error_code if error_code

    record_action(amount, type)
    return "Success"
  end

  # def set_date(year, month, day)
  #   @date = Date.new(year, month, day)
  # end

  private

  def record_action(amount, type)
    balance_adjust = (type == "withdraw" ? amount * -1 : amount)
    current_balance = balance + balance_adjust

    @records << @record_class.new(amount, type, current_balance)
  end
end
