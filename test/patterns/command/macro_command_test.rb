require File.dirname(__FILE__) + '/../../test_helper'

class MacroCommandTest < Test::Unit::TestCase
  
  def test_macro_command_execute
    vo = MacroCommandTestVO.new(5)
    note = Notification.new("MacroCommandTest", vo)
    command = MacroCommandTestCommand.new
    command.execute(note)
    assert_equal(10, vo.result1)
    assert_equal(25, vo.result2)
  end
end

class MacroCommandTestVO
  attr_accessor :input, :result1, :result2
  def initialize(number)
    @input = number
  end
end

class MacroCommandTestCommand < MacroCommand
  def initialize_macro_command
    self.add_sub_command(MacroCommandTestSub1Command)
    self.add_sub_command(MacroCommandTestSub2Command)
  end
end


class MacroCommandTestSub1Command < SimpleCommand
  def execute(note)
    vo = note.body
    vo.result1 = 2 * vo.input
  end
end

class MacroCommandTestSub2Command < SimpleCommand
  def execute(note)
    vo = note.body
    vo.result2 = vo.input * vo.input
  end
end
