require File.dirname(__FILE__) + '/test_helper'
require 'action_view/test_case'

def bp
  b = BoxPanel.new

  b.head do
    '<h1>Head</h1>'
  end

  b.body do
    '<p>Body</p>'
  end

  b
end

BP_HTML =
'<div class="box-panel">
  <div class="box-panel--head">
    <h1>Head</h1>
  </div>
  <div class="box-panel--body">
    <p>Body</p>
  </div>
</div>
'

class ViewComponentsHelperTest < ActionView::TestCase
  include ViewComponents::ViewComponentsHelper

  test 'box_panel' do
    c = box_panel do |b|
      b.head do
        '<h1>Head</h1>'
      end

      b.body do
        '<p>Body</p>'
      end
    end

    assert_equal BP_HTML, c
  end
end
