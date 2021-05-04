class BankTerminal
  def display_statement(records)
    result = ["date || credit || debit || balance"]
    return result[0] if records.empty?

    records.reverse.each do |entry|
      result.push(entry.display_string)
    end

    result.join("\n")
  end
end
