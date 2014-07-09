module ViewComponents
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'view_components.action_view' do |_app|
      ActiveSupport.on_load(:action_view) do
        require 'view_components/view_components_helper'
        ::ActionView::Base.send :include, ViewComponents::ViewComponentsHelper
      end
    end
  end
end
