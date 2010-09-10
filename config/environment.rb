# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Xmanager::Application.initialize!

WillPaginate::ViewHelpers.pagination_options[:previous_label] = I18n.t("will_paginate.previous_page")
WillPaginate::ViewHelpers.pagination_options[:next_label] = I18n.t("will_paginate.next_page")
