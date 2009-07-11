# Author:: Renat Akhmerov (mailto:renat@brainhouse.ru)
# Author:: Yury Kotlyarov (mailto:yura@brainhouse.ru)
# License:: MIT License

require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < Test::Unit::TestCase
  ## CLEANUP - all fixtures preloaded ## fixtures :dynamic_attributes, :dynamic_attribute_values, :addresses
  
  def test_truth
    a = Address.find(addresses(:full_address).id)
    assert_not_nil a
    assert_instance_of Address, a
    assert_valid a
    assert a.errors.empty?
    assert_equal addresses(:full_address), a
  end                          

  def test_display_name
    a = Address.find(addresses(:full_address).id)
    assert_equal "Worcester: Victoria Street, 27, Worcester, Worcestershire, 11111, UK", a.display_name
    
    a = Address.find(addresses(:empty_address).id)
    assert_equal "address ##{a.id}", a.display_name
  end
end
