class Account
  def new
    @balance = 0
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def deposit(amount)
    if @balance.nil?
      @balance = amount
    else
      @balance += amount
    end

    "You have deposited £#{display(amount)}."
  end

  private

  def display(value)
    value = 0 if value.nil?
    sprintf('%.2f', value)
  end
end
