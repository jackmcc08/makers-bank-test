require 'date'
require_relative 'record'
require_relative 'error_module'

class Account
  def initialize(record_class = Record)
    @record_class = record_class
    @records = []
  end

  include ErrorManager

  def balance
    @records.empty? ? 0 : @records.last.balance
  end

  def records_for_statement
    @records.reverse
  end

  def deposit(amount)
    record_action(amount, "deposit")
  end

  def withdraw(amount)
    check_balance(amount)
    record_action(amount, "withdraw")
  end

  private

  def record_action(amount, type)
    balance_adjust = (type == "withdraw" ? amount * -1 : amount)
    current_balance = balance + balance_adjust
    record = @record_class.new(amount, type, current_balance)
    @records << record
    record
  end
end
