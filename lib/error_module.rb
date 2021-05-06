module ErrorManager
  def validate_input(value, type)
    raise "Incorrect input detected. Please #{type} a numeric value." unless value.is_a? Numeric
    raise "You cannot #{type} a negative amount." if value.negative?
    raise "You cannot #{type} a zero amount." if value.zero?
  end

  def check_balance(amount)
    raise "You do not have enough money in your account." unless balance >= amount
  end
end
