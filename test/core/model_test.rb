require File.dirname(__FILE__) + '/../test_helper'

class ModelTest < Test::Unit::TestCase
  def test_get_instance
    model = Model.instance
    assert !model.nil?
    assert model.is_a?(Model)
  end
  
  def test_register_and_retrieve_proxy
    colors = ['red','green','blue']
    model = Model.instance
    model.register_proxy(Proxy.new('colors', colors ))
    proxy = model.retrieve_proxy('colors')
    assert_equal colors, proxy.data
  end
  
  def test_register_and_remove_proxy
    model = Model.instance
    proxy = Proxy.new('sizes', [1,2,3])
    model.register_proxy(proxy)
    
    removed_proxy = model.remove_proxy('sizes')
    assert_equal 'sizes', removed_proxy.name
    
    proxy = model.retrieve_proxy('sizes')
    assert proxy.nil?
  end
  
  def test_has_proxy
    model = Model.instance
    model.register_proxy(Proxy.new('aces', ['clubs', 'spades', 'hearts', 'diamonds']))
    assert model.has_proxy?('aces')
    
    model.remove_proxy('aces')
    assert !model.has_proxy?('aces')
  end
  
  def test_on_register_and_on_remove
    model = Model.instance
    proxy = ModelTestProxy.new
    model.register_proxy(proxy)
    assert_equal ModelTestProxy::ON_REGISTER_CALLED, proxy.data
  
    model.remove_proxy(proxy.name)
    assert_equal ModelTestProxy::ON_REMOVE_CALLED, proxy.data
  end
  
end

class ModelTestProxy < Proxy
  NAME = 'ModelTestProxy'
  ON_REGISTER_CALLED = 'onRegister Called'
  ON_REMOVE_CALLED = 'onRemove Called'
  
  def initialize
    super('NAME', '')
  end
  
  def on_register
    self.data = ON_REGISTER_CALLED
  end
  
  def on_remove
    self.data = ON_REMOVE_CALLED
  end
end
