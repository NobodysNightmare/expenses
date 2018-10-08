# frozen_string_literal: true

class ExpensesCsvImporter
  COL_SEP = "\t"

  def import(data)
    Expense.transaction do
      CSV.parse(data, col_sep: COL_SEP) do |row|
        date = Date.parse(row[0])
        amount = determine_amount(row[2], row[3])
        Expense.create!(
          date: date,
          description: row[1],
          amount: amount,
          category_id: Category.first.id # TODO: allow NULL category
        )
      end
    end
  end

  private

  def determine_amount(*columns)
    # TODO: remove currency and fix locale specifics
    columns.select(&:present?).map { |a| BigDecimal(a) }.sum
  end
end
