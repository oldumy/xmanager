module Rack
  module Utils
    def escape(s)
      EscapeUtils.escape_url(s)
    end
  end
end

require 'escape_utils/html/rack'
require 'escape_utils/html/erb'
require 'escape_utils/javascript/action_view'
