require 'test_helper'

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

class ViewComponentsTest < ActiveSupport::TestCase
  test 'Module' do
    assert_kind_of Module, ViewComponents
  end

  test 'Base class' do
    assert_kind_of Class, ViewComponents::Base
  end

  # Sections
  test 'respond to :sections method' do
    assert_respond_to ViewComponents::Base, :sections
  end

  test ':sections create methods with its arguments' do
    assert_respond_to bp, :head
    assert_respond_to bp, :body
  end

  test ':section _content should respond with its contents' do
    assert_equal bp.head_content, '<h1>Head</h1>'
    assert_equal bp.body_content, '<p>Body</p>'
  end

  # Template
  test ':template should default to underscored class name' do
    assert_equal SimpleBoxPanel.new.template, 'simple_box_panel'
  end

  test ':template should be overrided with :render_to method' do
    assert_equal bp.template, 'my_box_panel'
  end

  # Render Args
  test ':render_args' do
    bp_args = {
      template: 'view_components/my_box_panel',
      locals: {
        head: '<h1>Head</h1>',
        body: '<p>Body</p>'
      }
    }
    assert_equal bp.render_args, bp_args

    sbp_args = {
      template: 'view_components/simple_box_panel',
      locals: { a: nil, b: nil }
    }
    assert_equal SimpleBoxPanel.new.render_args, sbp_args
  end
end
