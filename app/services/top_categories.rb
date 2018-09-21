# frozen_string_literal: true

class TopCategories
  COUNT = 5

  attr_reader :expenses

  def initialize(expenses, interval)
    @expenses = expenses
    @interval = interval
  end

  def calculate
    Expense.where(date: DateInterval.interval(@interval, Date.current))
           .group(:category)
           .order('SUM(amount) DESC')
           .limit(COUNT)
           .sum(:amount)
  end
end
