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
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
