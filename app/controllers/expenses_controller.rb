# frozen_string_literal: true

class ExpensesController < ApplicationController
  def index
    @expenses = Expense.order(date: :desc)
                       .page(params[:page])
                       .per(100)
  end

  def new
    @expense = Expense.new(date: Date.today)
    render :edit
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    expense = Expense.create(expense_params)
    if expense.persisted?
      flash[:success] = I18n.t('flashs.created_model',
                               model: Expense.model_name.human)
    else
      flash_errors(expense.errors)
    end
    redirect_to action: :index
  end

  def update
    expense = Expense.find(params[:id])
    if expense.update(expense_params)
      flash[:success] = I18n.t('flashs.updated_model',
                               model: Expense.model_name.human)
    else
      flash_errors(expense.errors)
    end

    redirect_to action: :edit
  end

  def destroy
    Expense.find(params[:id]).destroy
    flash[:success] = I18n.t('flashs.destroyed_model',
                             model: Expense.model_name.human)
    redirect_to action: :index
  end

  private

  def expense_params
    params.require(:expense).permit(:date, :description, :category_id, :amount)
  end
end
