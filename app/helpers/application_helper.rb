# frozen_string_literal: true

module ApplicationHelper
  def category_options(selected = nil)
    categories = Category.all
    no_category = [[I18n.t('no_category'), '']]
    options_for_select(
      no_category + categories.map { |c| [c.name, c.id] },
      selected
    )
  end
end
