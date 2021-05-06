module Formatter
  def format(value)
    sprintf('%.2f', value)
  end

  def date_format(date)
    date.strftime("%d/%m/%Y")
  end
end
