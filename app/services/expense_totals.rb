# frozen_string_literal: true

class ExpenseTotals
  PreviousAndCurrent = Struct.new(:previous, :current)

  attr_reader :expenses

  def initialize(expenses)
    @expenses = expenses
  end

  def weekly
    @weekly ||= PreviousAndCurrent.new(
      expenses.where(date: week_for(Date.current - 1.week)).sum(:amount),
      expenses.where(date: week_for(Date.current)).sum(:amount)
    )
  end

  def monthly
    @monthly ||= PreviousAndCurrent.new(
      expenses.where(date: month_for(Date.current - 1.month)).sum(:amount),
      expenses.where(date: month_for(Date.current)).sum(:amount)
    )
  end

  def yearly
    @yearly ||= PreviousAndCurrent.new(
      expenses.where(date: year_for(Date.current - 1.year)).sum(:amount),
      expenses.where(date: year_for(Date.current)).sum(:amount)
    )
  end

  private

  def week_for(date)
    date.beginning_of_week..date.end_of_week
  end

  def month_for(date)
    date.beginning_of_month..date.end_of_month
  end

  def year_for(date)
    date.beginning_of_year..date.end_of_year
  end
end
