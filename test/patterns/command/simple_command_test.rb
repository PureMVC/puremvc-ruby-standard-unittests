require File.dirname(__FILE__) + '/../../test_helper'

class SimpleCommandTest < Test::Unit::TestCase

  def test_simple_command_execute
    vo = SimpleCommandTestVO.new(5)
    note = Notification.new("SimpleCommandTestNote", vo)
    command = SimpleCommandTestCommand.new
    command.execute(note)
    assert_equal(10, vo.result)
  end
  
end


class SimpleCommandTestVO
  attr_accessor :input, :result
  def initialize(input)
    @input = input
  end
end

class SimpleCommandTestCommand < SimpleCommand
  def execute(note)
    vo = note.body
    vo.result = vo.input * 2
  end
end


