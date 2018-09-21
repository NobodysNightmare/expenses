# frozen_string_literal: true

class DateInterval
  class << self
    def week(date)
      date.beginning_of_week..date.end_of_week
    end

    def month(date)
      date.beginning_of_month..date.end_of_month
    end

    def year(date)
      date.beginning_of_year..date.end_of_year
    end
  end
end
