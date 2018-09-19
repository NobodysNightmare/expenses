# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page])
                          .per(100)
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.create(category_params)
    if category.persisted?
      flash[:success] = I18n.t('flashs.created_model',
                               model: Category.model_name.human)
    else
      flash_errors(category.errors)
    end
    redirect_to action: :index
  end

  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      flash[:success] = I18n.t('flashs.updated_model',
                               model: Category.model_name.human)
    else
      flash_errors(category.errors)
    end

    redirect_to action: :edit
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = I18n.t('flashs.destroyed_model',
                             model: Category.model_name.human)
    redirect_to action: :index
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
