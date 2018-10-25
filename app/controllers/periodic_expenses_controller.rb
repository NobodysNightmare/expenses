# frozen_string_literal: true

class PeriodicExpensesController < ApplicationController
  def index
    @periodic_expenses = PeriodicExpense.order(:description)

    # FIXME: consider periodicity
    amount_term = 'amount / periodicity'
    @monthly_cost = PeriodicExpense.group(:category)
                                   .order("SUM(#{amount_term}) DESC")
                                   .sum(amount_term)
    @yearly_cost = @monthly_cost.map { |cat, cost| [cat, cost * 12] }.to_h
  end

  def new
    @periodic_expense = PeriodicExpense.new
    render :edit
  end

  def edit
    @periodic_expense = PeriodicExpense.find(params[:id])
  end

  def create
    periodic_expense = PeriodicExpense.create(periodic_expense_params)
    if periodic_expense.persisted?
      flash[:success] = I18n.t('flashs.created_model',
                               model: PeriodicExpense.model_name.human)
    else
      flash_errors(periodic_expense.errors)
    end
    redirect_to action: :index
  end

  def update
    periodic_expense = PeriodicExpense.find(params[:id])
    if periodic_expense.update(periodic_expense_params)
      flash[:success] = I18n.t('flashs.updated_model',
                               model: PeriodicExpense.model_name.human)
    else
      flash_errors(periodic_expense.errors)
    end

    redirect_to action: :edit
  end

  def destroy
    PeriodicExpense.find(params[:id]).destroy
    flash[:success] = I18n.t('flashs.destroyed_model',
                             model: PeriodicExpense.model_name.human)
    redirect_to action: :index
  end

  private

  def periodic_expense_params
    params.require(:periodic_expense).permit(:description, :category_id, :periodicity, :amount)
  end
end
