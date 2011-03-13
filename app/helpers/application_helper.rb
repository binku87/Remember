module ApplicationHelper
  def to_day value
    (value.to_f / (24 * 60 * 60)).round(1)
  end
end
