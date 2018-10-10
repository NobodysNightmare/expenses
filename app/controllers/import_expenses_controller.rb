# frozen_string_literal: true

class ImportExpensesController < ApplicationController
  def create
    importer = ExpensesCsvImporter.new
    imported_count = importer.import(params[:import_string])

    flash[:success] = t('.successful_import', count: imported_count)
    redirect_to import_expenses_path
  end

  def index; end
end
