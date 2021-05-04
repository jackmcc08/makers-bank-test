class Record
  def initialize(amount, type, date, balance)
    @amount = amount
    @type = type
    @date = date
    @balance = balance
  end

  def display_string
    amount = (@type == "deposit" ?
      " #{display(@amount)} || " :
      " || #{display(@amount)} ")

    "#{date_format(@date)} ||#{amount}|| #{display(@balance)}"
  end

  private

  def display(value)
    sprintf('%.2f', value)
  end

  def date_format(date)
    date.strftime("%d/%m/%Y")
  end
end
