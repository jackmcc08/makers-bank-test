class Account
  def new
    @balance = 0
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def deposit(amount)
    add_balance(amount)

    "You have deposited £#{display(amount)}."
  end

  private

  def display(value)
    value = 0 if value.nil?
    sprintf('%.2f', value)
  end

  def add_balance(value)
    return @balance = value if @balance.nil?

    @balance += value
  end
end
