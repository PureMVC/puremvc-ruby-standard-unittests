require File.dirname(__FILE__) + '/../../test_helper'

class NotificationTest < Test::Unit::TestCase

  def test_name_accessor
    notification = Notification.new("TestNotification")
    assert "TestNotification", notification.name
  end
  
  def test_body_accessor
    notification = Notification.new()
    notification.body = 5
    assert 5, notification.body
  end
  
  def test_constructor
    notification = Notification.new("TestNotification", 5, "TYPE")
    assert "TestNotification", notification.name
    assert 5, notification.body
    assert "TYPE", notification.type
  end
  
  def test_to_s
    notification = Notification.new("TestNote", [1,3,5], "TestType")
    assert "Notification Name: TestNote\nBody:1,3,5\nType:TestType", notification.to_s
  end
end
