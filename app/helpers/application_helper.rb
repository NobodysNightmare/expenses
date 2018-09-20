# frozen_string_literal: true

module ApplicationHelper
  def category_options(selected = nil)
    categories = Category.all
    options_for_select(
      categories.map { |c| [c.name, c.id] },
      selected
    )
  end
end
