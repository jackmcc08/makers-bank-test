require_relative 'formatter_module'

class Record
  def initialize(amount, type, date, balance)
    @amount = amount
    @type = type
    @date = date
    @balance = balance
  end

  include Formatter

  def display_string
    amount = (@type == "deposit" ?
      " #{format(@amount)} || " :
      " || #{format(@amount)} ")

    "#{date_format(@date)} ||#{amount}|| #{format(@balance)}"
  end
end
