module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice' then 'notification alert alert-info'
    when 'success' then 'notification alert alert-success'
    when 'error' then 'notification alert alert-danger'
    when 'alert' then 'notification alert alert-warning'
    end
  end
end
