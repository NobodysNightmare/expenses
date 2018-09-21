# frozen_string_literal: true

class TopCategories
  attr_reader :expenses

  def initialize(expenses)
    @expenses = expenses
  end

  def calculate
    Expense.where(date: DateInterval.month(Date.current))
           .group(:category)
           .order('SUM(amount) DESC')
           .limit(5)
           .sum(:amount)
  end
end
