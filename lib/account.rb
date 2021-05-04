class Account
  def initialize
    @balance = 0
    @records = []
  end

  def see_balance
    "Account balance: £#{display(@balance)}."
  end

  def statement
    result = ["date || credit || debit || balance"]
    return result[0] if @records.empty?

    @records.reverse.each { |entry| result << entry }

    result.join("\n")
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
    @records << "01/01/2012 || || #{display(amount)} || #{display(@balance)}"

    "You have withdrawn £#{display(amount)}."
  end

  private

  def display(value)
    sprintf('%.2f', value)
  end

  def add_balance(value)
    @balance += value


    @records << "01/01/2012 || #{display(value)} || || #{display(@balance)}"
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
