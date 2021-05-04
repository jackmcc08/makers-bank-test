class Account
  def new
    @balance = 0.00
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def deposit(amount)
    "You have deposited £#{display(amount)}."
  end

  private

  def display(value)
    value = 0 if value.nil?
    sprintf('%.2f', value)
  end
end
