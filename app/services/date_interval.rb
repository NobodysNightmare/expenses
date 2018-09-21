# frozen_string_literal: true

class DateInterval
  INTERVAL_TYPES = %i[week month year].freeze

  class << self
    def interval(type, date)
      check_interval_type!(type)
      public_send(type, date)
    end

    def week(date)
      date.beginning_of_week..date.end_of_week
    end

    def month(date)
      date.beginning_of_month..date.end_of_month
    end

    def year(date)
      date.beginning_of_year..date.end_of_year
    end

    private

    def check_interval_type!(type)
      raise ArgumentError, "Unsupported interval type '#{type}'" unless INTERVAL_TYPES.include?(type.to_sym)
    end
  end
end
