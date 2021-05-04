class Account
  def new
    @balance = 0.00
  end

  def see_balance
    "Account balance: £#{balance_display}."
  end

  def deposit(amount)
    "You have deposited £#{sprintf('%.2f', amount)}."
  end

  private

  def balance_display
    @balance.nil? ? "0.00" : @balance
  end
end
