module ViewComponents
  module Componentable
    extend ActiveSupport::Concern

    included do
      def render_args
        h = {
          template: "view_components/#{template}",
          locals: {}
        }

        sections.each do |s|
          h[:locals][s.to_sym] = send("#{s}_content").try(:html_safe)
        end

        h
      end

      def template
        if self.class.respond_to?(:view_component_template)
          self.class.view_component_template
        else
          self.class.to_s.underscore
        end
      end
    end

    module ClassMethods
      # For each <tt>:section</tt> received it creates:
      ## An instance method <tt>:section</tt>(&block) that should save the block
      ## yield call to a new instance variable <tt>:section</tt>_content
      def sections(*secs)
        __add_sections_method(secs)
        __add_section_blocks(secs)
      end

      def render_to(template)
        # TODO: check out later if well done
        cattr_accessor :view_component_template
        self.view_component_template = template
      end

      private

      def __add_section_blocks(secs)
        secs.each do |section|
          cname = "#{section}_content"
          send :attr_reader, cname
          class_eval %Q"
            def #{section}(&block)
              @#{cname} = yield
            end
          "
        end
      end

      def __add_sections_method(secs)
        class_eval %Q"
          def sections
            #{secs}
          end
        "
      end
    end
  end
end
