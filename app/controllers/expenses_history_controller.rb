# frozen_string_literal: true

class ExpensesHistoryController < ApplicationController
  ROW_COUNT = 12

  def index
    @chosen_interval = params[:interval] || :month
    @expense_totals = []
    interval = DateInterval.new(@chosen_interval, Date.current)

    # this is guaranteed to fire off multiple SQL queries, but
    # also does not rely on any DBMS specific features or correct setting
    # of things like start of week. Should work good enough
    # for expected amount of data
    ROW_COUNT.times do
      @expense_totals << [interval.display_name, Expense.where(date: interval.range).sum(:amount)]
      interval = interval.previous
    end
  end
end
