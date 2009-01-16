require File.dirname(__FILE__) + '/../../test_helper'

class ObserverTest < Test::Unit::TestCase

  def test_observer_accessors
    observer = Observer.new(nil, nil)
    observer.context = self
    observer.notify = :observer_test_method
    note = Notification.new("ObserverTestNote", 5)
    observer.notify_observer(note)
    assert_equal 5, @observer_test_var
  end
  
  def test_compare_notify_context
    observer = Observer.new(:observer_test_method, self)
    assert !observer.compare_notify_context(Observer.new)
    assert observer.compare_notify_context(self)
  end
  
  
  attr_accessor :observer_test_var
  def observer_test_method(note)
    @observer_test_var = note.body
  end
end

