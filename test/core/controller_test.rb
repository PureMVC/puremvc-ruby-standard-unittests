require File.dirname(__FILE__) + '/../test_helper'

class ControllerTest < Test::Unit::TestCase

  def test_get_instance
    controller = Controller.instance
    assert !controller.nil?
    assert controller.is_a?(Controller)
  end
  
  def test_register_and_execute_command
    controller = Controller.instance
    controller.register_command('ControllerTest', ControllerTestCommand)
    vo = ControllerTestVO.new(12)
    note = Notification.new('ControllerTest', vo)
    controller.execute_command(note)
    assert_equal 24, vo.result
  end
  
  def test_register_and_remove_command
    controller = Controller.instance
    controller.register_command('ControllerRemoveTest', ControllerTestCommand)
    vo = ControllerTestVO.new(12)
    note = Notification.new('ControllerRemoveTest', vo)
    controller.execute_command(note)
    assert_equal 24, vo.result
    
    vo.result = 0
    controller.remove_command('ControllerRemoveTest')
    controller.execute_command(note)
    assert_equal 0, vo.result
  end
  
  def test_has_command
    controller = Controller.instance
    controller.register_command('HasCommandTest', ControllerTestCommand)
    assert controller.has_command?('HasCommandTest')
    
    controller.remove_command('HasCommandTest')
    assert !controller.has_command?('HasCommandTest')
  end
  
  def test_re_register_and_execute_command
    controller = Controller.instance
    controller.register_command('ControllerTest2', ControllerTestCommand)
    controller.remove_command('ControllerTest2')
    controller.register_command('ControllerTest2', ControllerTestCommand)
    
    vo = ControllerTestVO.new(12)
    note = Notification.new('ControllerTest2', vo)
    view = View.instance
    view.notify_observers(note)
    assert 24, vo.result

    view.notify_observers(note)
    assert 48, vo.result
    
  end
  
end

class ControllerTestVO
  attr_accessor :input, :result
  def initialize(input)
    @input = input
  end
end

class ControllerTestCommand < SimpleCommand
  def execute(note)
    vo = note.body
    vo.result = vo.input * 2
  end
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
