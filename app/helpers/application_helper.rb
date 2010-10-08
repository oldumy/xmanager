module ApplicationHelper
  def app_top_banner(project)
    content_tag(:h1, project.nil? || project.name.blank? ? Settings.app.title : project.name)
  end

  def no_record_found(needed)
    needed ? content_tag(:p, t("notices.no_record_found"), :id => 'no-record-found') : ''
  end

  def errors_of(model)
    if model.errors.any?
      content_tag(:div, :id => 'error_explanation') do
        content_tag(:h2, t("notices.errors.save", :name => t("models.names.#{model.class.name.underscore}"), :count => model.errors.count)) +
        content_tag(:ul) do
          lines = ''
          model.errors.each do |attr, msg|
            lines += content_tag(:li) do
              attr.blank? ? msg : content_tag(:label, t("labels.#{attr.to_s.downcase}")) + " " + msg
            end
          end
          lines
        end
      end
    end
  end
end
