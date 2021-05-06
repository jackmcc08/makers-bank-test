module ErrorManager
  def input_invalid(value, type)
    return "FAIL:NAN" unless value.is_a? Numeric
    return "FAIL:NEG" if value.negative?
    return "FAIL:ZER" if value.zero?
    return "FAIL:NEM" unless enough_balance?(value, type)

    false
  end

  def enough_balance?(amount, type)
    return true if type == "deposit"

    balance >= amount
  end

  def input_error_message(code, type)
    return "Incorrect input detected. Please #{type} a numeric value." if
    code == "FAIL:NAN"
    return "You cannot #{type} a negative amount." if code == "FAIL:NEG"
    return "You cannot #{type} a zero amount." if code == "FAIL:ZER"
    return "You do not have enough money in your account." if code == "FAIL:NEM"
  end

  # def date_error(year, month, day)
  #   return "FAIL:D_YR" unless year.digits.count == 4
  #   return "FAIL:D_MO" unless month.digits.count == 1 || month.digits.count == 2
  #   return "FAIL:D_DY" unless day.digits.count == 1 || day.digits.count == 2
  #
  #   false
  # end
  #
  # def date_error_message(code)
  #   return "Year must be an 4 digit integer." if code == "FAIL:D_YR"
  #   return "Month must be a 1 or 2 digit integer." if code == "FAIL:D_MO"
  #   return "Day must be a 1 or 2 digit integer." if code == "FAIL:D_DY"
  # end
end
