class BankTerminal
  def display_statement(records)
    result = ["date || credit || debit || balance"]
    return result[0] if records.empty?

    records.reverse.each do |entry|
      result.push(entry.display_string)
    end

    result.join("\n")
  end

  def action_confirmation(type, amount)
    type_display = (type == "deposit" ? "deposited" : "withdrawn")
    "You have #{type_display} £#{display(amount)}."
  end

  private

  def display(value)
    sprintf('%.2f', value)
  end
end
