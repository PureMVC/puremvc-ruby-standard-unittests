require File.dirname(__FILE__) + '/../../test_helper'

class ProxyTest < Test::Unit::TestCase
  
  def setup
    @proxy = Proxy.new("TestProxy")
    @sample_data = ['red', 'blue', 'green']
  end
  
  def test_name_accessor
    assert_equal("TestProxy", @proxy.name)
  end
  
  def test_data_accessors
    @proxy.data = @sample_data
    assert_equal(@sample_data, @proxy.data)
  end
  
  def test_constructor
    proxy = Proxy.new("TestProxy", @sample_data)
    assert !proxy.nil?
    assert_equal(@sample_data, proxy.data)
  end
  
end
# PureMVC Port to Ruby by Jake Dempsey <jake.dempsey@puremvc.org>
# PureMVC - Copyright(c) 2006-2008 Futurescale, Inc., Some rights reserved.
# Your reuse is governed by the Creative Commons Attribution 3.0 License
