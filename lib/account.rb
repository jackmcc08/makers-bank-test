class Account
  def new
    @balance = 0.00
  end

  def see_balance
    balance = (@balance.nil? ? "0.00" : @balance)
    "Account balance: £#{balance}."
  end
end
