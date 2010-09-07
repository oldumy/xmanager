class Settings < Settingslogic
  source "#{Rails.root}/config/xmanager.yml"
  namespace Rails.env
end
