class Account
  def new
    @balance = 0
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def deposit(amount)
    return invalid_message(amount) if input_valid?(amount)

    add_balance(amount)

    "You have deposited £#{display(amount)}."
  end

  def withdraw(amount)
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

  def input_valid?(value)
    return true unless value.is_a? Numeric
    return true if value.negative?
    return true if value.zero?

    false
  end

  def invalid_message(value)
    return "Incorrect input detected. Please deposit a positive numeric value." unless
    value.is_a? Numeric
    return "You cannot deposit a negative amount." if value.negative?
    return "You cannot deposit a zero amount." if value.zero?
  end
end
