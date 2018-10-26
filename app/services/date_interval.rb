# frozen_string_literal: true

class DateInterval
  INTERVAL_TYPES = %i[week month year].freeze

  def initialize(type, date)
    check_interval_type!(type)
    @type = type
    @date = date
  end

  def range
    @date.public_send("beginning_of_#{@type}")..@date.public_send("end_of_#{@type}")
  end

  def display_name
    case @type.to_sym
    when :week
      @date.strftime('%V / %G')
    when :month
      @date.strftime('%B %Y')
    when :year
      @date.strftime('%Y')
    end
  end

  def previous
    self.class.new(@type, @date - 1.public_send(@type))
  end

  def next
    self.class.new(@type, @date + 1.public_send(@type))
  end

  private

  def check_interval_type!(type)
    raise ArgumentError, "Unsupported interval type '#{type}'" unless INTERVAL_TYPES.include?(type.to_sym)
  end
end
