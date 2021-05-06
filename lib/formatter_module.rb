module Formatter
  def format(value)
    sprintf('%.2f', value)
  end

  def date_format(date)
    date.strftime("%d/%m/%Y")
  end

  def statement_format(record)
    amount = (record.type == "deposit" ?
      " #{format(record.amount)} || " :
      " || #{format(record.amount)} ")

    "#{date_format(record.timestamp)} ||#{amount}|| #{format(record.balance)}"
  end
end
