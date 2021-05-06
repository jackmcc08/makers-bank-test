require_relative 'formatter_module'

class Record
  def initialize(amount, type, balance)
    @amount = amount
    @type = type
    @timestamp = Time.now
    @balance = balance
  end

  attr_reader :amount, :type, :date, :balance

end
