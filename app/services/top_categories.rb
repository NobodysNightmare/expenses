# frozen_string_literal: true

class TopCategories
  COUNT = 5

  attr_reader :expenses

  def initialize(expenses, interval)
    @expenses = expenses
    @interval = interval
  end

  def calculate
    Expense.where(date: DateInterval.new(@interval, Date.current).range)
           .group(:category)
           .order('SUM(amount) DESC')
           .limit(COUNT)
           .sum(:amount)
  end
end
