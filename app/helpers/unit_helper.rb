# frozen_string_literal: true

module UnitHelper
  def format_amount(value)
    number_to_currency(value, locale: I18n.locale, unit: '€')
  end
end
