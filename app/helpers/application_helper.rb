module ApplicationHelper
  def class_active path
    request.path == path ? "active" : ""
  end
end
