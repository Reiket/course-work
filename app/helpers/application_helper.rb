module ApplicationHelper
  def active_class_for_path(path)
    current_page?(path) ? "active" : ""
  end
end
