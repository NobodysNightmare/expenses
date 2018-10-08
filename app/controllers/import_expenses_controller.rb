# frozen_string_literal: true

class ImportExpensesController < ApplicationController
  def create
    ExpensesCsvImporter.new.import(params[:import_string])
    redirect_to import_expenses_path
  end

  def index; end
end
