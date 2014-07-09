module ViewComponents
  module ViewComponentsHelper
    Dir["#{Rails.root}/app/view_components/*.rb"].each { |file| require_dependency file }

    ViewComponents::Base.descendants.each do |vc|
      klass_name = vc.to_s
      klass_name_u = klass_name.underscore

      class_eval %Q"
        def #{klass_name_u}(options = {}, &block)
          obj = #{klass_name}.new
          yield obj
          render obj.render_args
        end
      "
    end
  end
end
