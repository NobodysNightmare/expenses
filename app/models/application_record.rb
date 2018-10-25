# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def human_enum_value(enum)
    I18n.t("enums.#{self.class.model_name.i18n_key}.#{enum.to_s.pluralize}.#{public_send(enum)}")
  end
end
