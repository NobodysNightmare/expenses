# frozen_string_literal: true

class ExpensesSummaryController < ApplicationController
  def index
    @latest_expenses = Expense.order(date: :desc)
                              .limit(5)
    @expense_totals = ExpenseTotals.new(Expense.all)
    @top_categories = TopCategories.new(Expense.all).calculate
  end
end
