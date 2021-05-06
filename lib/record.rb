require_relative 'formatter_module'

class Record
  def initialize(amount, type, date, balance)
    @amount = amount
    @type = type
    @date = date
    @balance = balance
  end

  attr_reader :amount, :type, :date, :balance

end
