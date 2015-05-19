module UserHelper
  def custom_time_ago_in_words(time_val)
    time_val.present? ? content_tag(:abbr, "#{time_val.to_s}", class: "timeago", title: "#{time_val.getutc.iso8601}") : "-"
  end

  # Required password and password confirmation for new object of user
  def require_password?(action)
    action == "new" ? true : false
  end

  # Required password label
  def required_password_label(action)
    action == "new" ? "Password <span class='required'/>".html_safe : "Password"
  end

  # Required confirm_password label
  def required_confirm_password_label(action)
    action == "new" ? "Confirm Password <span class='required'/>".html_safe : "Confirm Password"
  end

end
