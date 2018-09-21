# frozen_string_literal: true

class ExpensesSummaryController < ApplicationController
  def index
    @latest_expenses = Expense.order(date: :desc)
                              .limit(5)
    @expense_totals = ExpenseTotals.new(Expense.all)
  end

  def top_categories
    @top_categories = TopCategories.new(Expense.all, params[:interval]).calculate
    render layout: false
  end
end
