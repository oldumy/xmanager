module MenusHelper
  def menus(user, menu = nil, prefix = '')
    content_tag(:div, :id => "main-menu") do
      content_tag(:ul) do
        menus = ""
        Settings.menus.send(user.role.role_name.downcase.to_sym).each do |m|
          menus += content_tag(:li, :id => "menus-#{m[0].gsub(/_/, '-')}") do
            if m[0].to_sym == menu
              link_to t("menus.#{m[0]}"), prefix + m[1], :class => 'selected' 
            else
              link_to t("menus.#{m[0]}"), prefix + m[1] 
            end
          end
        end
        menus
      end
    end
  end
end
