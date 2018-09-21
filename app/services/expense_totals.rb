# frozen_string_literal: true

class ExpenseTotals
  PreviousAndCurrent = Struct.new(:previous, :current)

  attr_reader :expenses

  def initialize(expenses)
    @expenses = expenses
  end

  def weekly
    @weekly ||= PreviousAndCurrent.new(
      expenses.where(date: DateInterval.week(Date.current - 1.week)).sum(:amount),
      expenses.where(date: DateInterval.week(Date.current)).sum(:amount)
    )
  end

  def monthly
    @monthly ||= PreviousAndCurrent.new(
      expenses.where(date: DateInterval.month(Date.current - 1.month)).sum(:amount),
      expenses.where(date: DateInterval.month(Date.current)).sum(:amount)
    )
  end

  def yearly
    @yearly ||= PreviousAndCurrent.new(
      expenses.where(date: DateInterval.year(Date.current - 1.year)).sum(:amount),
      expenses.where(date: DateInterval.year(Date.current)).sum(:amount)
    )
  end
end
