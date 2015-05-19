module ApplicationHelper

  def date_format(date)
    date.strftime("%m-%d-%Y %I:%M%p") if date.present?
  end
end
