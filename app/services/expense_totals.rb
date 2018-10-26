# frozen_string_literal: true

class ExpenseTotals
  PreviousAndCurrent = Struct.new(:previous, :current)

  attr_reader :expenses

  def initialize(expenses)
    @expenses = expenses
  end

  def weekly
    @weekly ||= PreviousAndCurrent.new(
      expenses.where(date: this_week.previous.range).sum(:amount),
      expenses.where(date: this_week.range).sum(:amount)
    )
  end

  def monthly
    @monthly ||= PreviousAndCurrent.new(
      expenses.where(date: this_month.previous.range).sum(:amount),
      expenses.where(date: this_month.range).sum(:amount)
    )
  end

  def yearly
    @yearly ||= PreviousAndCurrent.new(
      expenses.where(date: this_year.previous.range).sum(:amount),
      expenses.where(date: this_year.range).sum(:amount)
    )
  end

  private

  def this_week
    DateInterval.new(:week, Date.current)
  end

  def this_month
    DateInterval.new(:month, Date.current)
  end

  def this_year
    DateInterval.new(:year, Date.current)
  end
end
