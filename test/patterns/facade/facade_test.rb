require File.dirname(__FILE__) + '/../../test_helper'

class FacadeTest < Test::Unit::TestCase
  
  def test_get_instance
    facade = Facade.instance
    assert !facade.nil?
    assert facade.is_a?(Facade)
  end
  
  def test_register_command_and_send_notification
    facade = Facade.instance
    facade.register_command('FacadeTestNote', FacadeTestCommand)
    vo = FacadeTestVO.new(32)
    facade.send_notification('FacadeTestNote', vo)
    assert vo.result == 64
  end
  
  def test_register_and_remove_command_and_send_notification
    facade = Facade.instance
    facade.register_command('FacadeTestNote', FacadeTestCommand)
    facade.remove_command('FacadeTestNote')
    
    vo = FacadeTestVO.new(32)
    facade.send_notification('FacadeTestNote',vo)
    assert vo.result != 64
  end
  
  def test_register_and_retrieve_proxy
    facade = Facade.instance
    facade.register_proxy(Proxy.new('colors', ['red', 'green', 'blue']))
    proxy = facade.retrieve_proxy('colors')
    assert proxy.is_a?(Proxy)
    data = proxy.data
    assert !data.nil?
    assert data.size == 3
    assert data[0] == 'red'
    assert data[1] == 'green'
    assert data[2] == 'blue'
  end
  
  def test_register_and_remove_proxy
    facade = Facade.instance
    proxy = facade.register_proxy(Proxy.new('sizes', [7,13,21]))
    removed_proxy = facade.remove_proxy('sizes')
    assert removed_proxy.name == 'sizes'
    
    proxy = facade.retrieve_proxy('sizes')
    assert proxy.nil?
  end
  
  def test_register_retrive_and_remove_mediator
    facade = Facade.instance
    facade.register_mediator(Mediator.new("TestMediator"))
    assert !facade.retrieve_mediator("TestMediator").nil?
    
    removed_mediator = facade.remove_mediator("TestMediator")
    assert removed_mediator.name == "TestMediator"
    assert facade.retrieve_mediator("TestMediator").nil?
  end
  
  def test_has_proxy
    facade = Facade.instance
    facade.register_proxy(Proxy.new('hasProxyTest', [1,2,3]))
    assert facade.has_proxy?('hasProxyTest')
  end
  
  def test_has_mediator
    facade = Facade.instance
    facade.register_mediator(Mediator.new('facadeHasMediatorTest'))
    assert facade.has_mediator?('facadeHasMediatorTest')
    facade.remove_mediator('facadeHasMediatorTest')
    assert !facade.has_mediator?('facadeHasMediatorTest')
  end
  
  def test_has_command
    facade = Facade.instance
    facade.register_command('facadeHasCommandTest', FacadeTestCommand)
    assert facade.has_command?('facadeHasCommandTest')
    facade.remove_command('facadeHasCommandTest')
    assert !facade.has_command?('facadeHasCommandTest')
  end
  
  
end
  
class FacadeTestCommand
  def execute(notification)
    vo = notification.body
    vo.result = 2 * vo.input
  end
end
  
class FacadeTestVO
  attr_accessor :input, :result

  def initialize(input)
    self.input = input
  end
  
end