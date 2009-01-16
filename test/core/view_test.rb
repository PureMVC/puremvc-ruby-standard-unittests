require File.dirname(__FILE__) + '/../test_helper'

class ViewTest < Test::Unit::TestCase
  NOTE1 = "Notification1"
  NOTE2 = "Notification2"
  NOTE3 = "Notification3"
  NOTE4 = "Notification4"
  NOTE5 = "Notification5"
  NOTE6 = "Notification6"
  
  attr_accessor :last_notification, :on_register_called, :on_remove_called, :counter, :view_test_var
  
  
  def setup
    @last_notification = nil
    @on_remove_called = false
    @on_register_called = false
    @counter = 0
    @view_test_var = nil
  end
  
#  def test_get_instance
#    view = View.instance
#    assert !view.nil?
#    assert view.is_a?(View)
#  end
#  
#  def test_register_and_notify_observer
#    view = View.instance
#    observer = Observer.new(:view_test_method, self)
#    view.register_observer(ViewTestNote::NAME, observer)
#    
#    note = ViewTestNote.create(10)
#    view.notify_observers(note)
#    assert @view_test_var == 10
#    
#  end
#  
#  def view_test_method(note)
#    @view_test_var = note.body
#  end
#  
#  def test_register_and_retrieve_mediator
#    view = View.instance
#    view_test_mediator = ViewTestMediator.new(self)
#    view.register_mediator(view_test_mediator)
#    mediator = view.retrieve_mediator(ViewTestMediator::NAME)
#    assert mediator.is_a?(ViewTestMediator)
#    cleanup
#  end
#  
#  def test_has_mediator
#    view = View.instance
#    mediator = Mediator.new('hasMediatorTest', self)
#    view.register_mediator(mediator)
#    assert view.has_mediator?('hasMediatorTest')
#    view.remove_mediator('hasMediatorTest')
#    assert !view.has_mediator?('hasMediatorTest')
#    cleanup
#  end
#  
#  def test_register_and_remove_mediator
#    view = View.instance
#    mediator = Mediator.new('testing', self)
#    view.register_mediator(mediator)
#    removed_mediator = view.remove_mediator('testing')
#    assert removed_mediator.name == 'testing'
#    assert view.retrieve_mediator('testing').nil?
#  end
#  
#  def test_on_register_and_on_remove
#    view = View.instance
#    mediator = ViewTestMediator4.new(self)
#    view.register_mediator(mediator)
#    assert @on_register_called == true
#    view.remove_mediator(ViewTestMediator4::NAME)
#    assert @on_remove_called == true
#    cleanup
#  end
#  
#  def test_successive_register_and_remove_mediator
#    view = View.instance
#    view.register_mediator(ViewTestMediator.new(self))
#    assert view.retrieve_mediator(ViewTestMediator::NAME).is_a?(ViewTestMediator)
#  
#    view.remove_mediator(ViewTestMediator::NAME)
#    assert view.remove_mediator(ViewTestMediator::NAME).nil?
#    assert view.remove_mediator(ViewTestMediator::NAME).nil?
#  
#    view.register_mediator(ViewTestMediator.new(self))
#    assert view.retrieve_mediator(ViewTestMediator::NAME).is_a?(ViewTestMediator)
#    
#    view.remove_mediator(ViewTestMediator::NAME)
#    assert view.retrieve_mediator(ViewTestMediator::NAME).nil?
#    cleanup
#  end
#  
#  def test_remove_mediator_and_subsequent_notify
#    view = View.instance
#    view.register_mediator(ViewTestMediator2.new(self))
#    view.register_mediator(ViewTestMediator3.new(self))
#    
#    view.notify_observers(Notification.new(NOTE1))
#    assert @last_notification == NOTE1
#    
#    view.notify_observers(Notification.new(NOTE2))
#    assert @last_notification == NOTE2
#    
#    view.remove_mediator(ViewTestMediator2::NAME)
#    assert view.retrieve_mediator(ViewTestMediator2::NAME).nil?
#    
#    @last_notification = nil
#    view.notify_observers(Notification.new(NOTE1))
#    assert @last_notification == nil
#    
#    view.notify_observers(Notification.new(NOTE2))
#    assert @last_notification == nil
#
#    view.notify_observers(Notification.new(NOTE3))
#    assert @last_notification == NOTE3
#
#    cleanup
#  end
#  
#  def test_mediator_registration
#    view = View.instance
#    view.register_mediator(ViewTestMediator5.new(self))
#    view.register_mediator(ViewTestMediator5.new(self))
#    @counter = 0
#    view.notify_observers(Notification.new(NOTE5))
#    assert @counter == 1
#    
#    view.remove_mediator(ViewTestMediator5::NAME)
#    assert view.retrieve_mediator(ViewTestMediator5::NAME).nil?
#    
#    @counter = 0
#    view.notify_observers(Notification.new(NOTE5))
#    assert @counter == 0
#  end
  
  def test_modify_observer_list_during_notification
    view = View.instance
    view.register_mediator(ViewTestMediator6.new("1", self))
    view.register_mediator(ViewTestMediator6.new("2", self))
    view.register_mediator(ViewTestMediator6.new("3", self))
    view.register_mediator(ViewTestMediator6.new("4", self))
    view.register_mediator(ViewTestMediator6.new("5", self))
    view.register_mediator(ViewTestMediator6.new("6", self))
    view.register_mediator(ViewTestMediator6.new("7", self))
    view.register_mediator(ViewTestMediator6.new("8", self))
    
    @counter = 0
    view.notify_observers(Notification.new(NOTE6))
    assert @counter == 8
    
    @counter = 0
    view.notify_observers(Notification.new(NOTE6))
    assert @counter == 0
  end
  
  
  def cleanup
    view = View.instance
    view.remove_mediator(ViewTestMediator::NAME)
    view.remove_mediator(ViewTestMediator2::NAME)
#    view.remove_mediator(ViewTestMediator3::NAME)
  end
  
end

class ViewTestNote < Notification
  attr_accessor :number
  NAME = "ViewTestNote"

  def initialize(name, body)
    super(NAME, body)
  end
  
  def self.create(body)
    return ViewTestNote.new(NAME, body)
  end
end

class ViewTestMediator < Mediator
  NAME = "ViewTestMediator"
  
  def initialize(view)
    super(NAME, view)
  end
  
  def list_notification_interests
    [ 'ABC', 'DEF', 'GHI'  ]
  end
end

class ViewTestMediator2 < Mediator
  NAME = "ViewTestMediator2"
  
  def initialize(view)
    super(NAME, view)
  end
  
  def list_notification_interests
    [ ViewTest::NOTE1,  ViewTest::NOTE2 ]
  end
  
  def handle_notification(note)
    view_test.last_notification = note.name
  end
  
  def view_test
    self.view
  end
end

class ViewTestMediator3 < Mediator
  NAME = "ViewTestMediator3"
  
  def initialize(view)
    super(NAME, view)
  end
  
  def list_notification_interests
    [ ViewTest::NOTE3 ]
  end
  
  def handle_notification(note)
    view_test.last_notification = note.name
  end
  
  def view_test
    self.view
  end
end

class ViewTestMediator4 < Mediator
  NAME = "ViewTestMediator4"
  
  def initialize(view)
    super(NAME, view)
  end
  
  def view_test
    self.view
  end
  
  def on_register
    view_test.on_register_called = true
  end

  def on_remove
    view_test.on_remove_called = true
  end
  
end

class ViewTestMediator5 < Mediator
  NAME = "ViewTestMediator5"
  
  def initialize(view)
    super(NAME, view)
  end
  
  def list_notification_interests
    [ ViewTest::NOTE5 ]
  end
  
  def handle_notification(note)
    view_test.counter += 1
  end
  
  def view_test
    self.view
  end
end

class ViewTestMediator6 < Mediator
  NAME = "ViewTestMediator6"

  def list_notification_interests
    [ ViewTest::NOTE6 ]
  end
  
  def handle_notification(note)
    facade.remove_mediator(self.name)
  end
  
  def on_remove
    view_test.counter += 1
  end
  
  def view_test
    self.view
  end
end