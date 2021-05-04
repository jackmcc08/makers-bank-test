class Account
  def new
    @balance = 0
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def statement
    "date || credit || debit || balance"
  end

  def deposit(amount)
    return invalid_message(amount, "deposit") if input_invalid?(amount)

    add_balance(amount)

    "You have deposited £#{display(amount)}."
  end

  def withdraw(amount)
    return invalid_message(amount, "withdraw") if input_invalid?(amount)

    return "You do not have enough money in your account." if @balance < amount

    @balance -= amount

    "You have withdrawn £#{display(amount)}."
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

  def input_invalid?(value)
    return true unless value.is_a? Numeric
    return true if value.negative?
    return true if value.zero?

    false
  end

  def invalid_message(value, type)
    return "Incorrect input detected. Please #{type} a positive numeric value." unless
    value.is_a? Numeric
    return "You cannot #{type} a negative amount." if value.negative?
    return "You cannot #{type} a zero amount." if value.zero?
  end
end
