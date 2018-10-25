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

  # TODO: for some reason enum_options is already defined, but it does not use
  # model.model_name.i18n_key for the model part of the i18n key and it does not
  # pluralize the enum name itself... I also could
  # not find any documentation about it...
  def my_enum_options(model, enum, selected = nil)
    model_key = model.model_name.i18n_key
    enum_key = enum.to_s.pluralize
    options = model.public_send(enum_key).map do |identifier, _|
      [
        I18n.t("enums.#{model_key}.#{enum_key}.#{identifier}"),
        identifier
      ]
    end
    options_for_select(options, selected)
  end
end
