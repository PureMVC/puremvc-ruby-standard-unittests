require File.dirname(__FILE__) + '/../../test_helper'

class MediatorTest < Test::Unit::TestCase

  def test_name_accessor
    mediator = Mediator.new("TestMediator")
    assert_equal("TestMediator", mediator.name)
  end
  
  def test_view_accessor
    view = Object.new
    mediator = Mediator.new("TestMediator", view)
    assert_equal view, mediator.view
  end
  
end
