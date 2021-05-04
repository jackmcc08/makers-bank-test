class Record
  def initialize(amount, type, date, balance)
    @amount = amount
    @type = type
    @date = date
    @balance = balance
  end

  def display_string
    if @type == "deposit"
      "#{@date} || #{display(@amount)} || || #{display(@balance)}"
    elsif @type == "withdraw"
      "#{@date} || || #{display(@amount)} || #{display(@balance)}"
    end
  end

  private

  def display(value)
    sprintf('%.2f', value)
  end
end
