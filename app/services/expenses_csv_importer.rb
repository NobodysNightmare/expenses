# frozen_string_literal: true

require 'csv'

class ExpensesCsvImporter
  COL_SEP = "\t"

  def import(data)
    rows = CSV.parse(data, col_sep: COL_SEP)
    Expense.transaction do
      rows.each do |row|
        date = Date.parse(row[0])
        amount = determine_amount(row[2], row[3])
        Expense.create!(date: date, description: row[1], amount: amount)
      end
    end

    rows.size
  end

  private

  def determine_amount(*columns)
    columns.select(&:present?).map { |a| BigDecimal(a) }.sum
  end
end
