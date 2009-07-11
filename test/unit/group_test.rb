# Author:: Renat Akhmerov (mailto:renat@brainhouse.ru)
# Author:: Yury Kotlyarov (mailto:yura@brainhouse.ru)
# License:: MIT License

require File.dirname(__FILE__) + '/../test_helper'

class GroupTest < ActiveSupport::TestCase
  fixtures :dynamic_attributes, :dynamic_attribute_values, :groups, :contacts, :contacts_groups, :group_types

  def test_truth
    nexus10 = groups(:nexus10)
    assert_not_nil nexus10
    assert_instance_of Group, nexus10
    assert_valid nexus10
    assert nexus10.errors.empty?
  end
  
  def test_display_name
    assert_equal 'Nexus 10', Group.find(groups(:nexus10).id).display_name
    
    g = Group.create :parent_id => 0, :depth => 0
    assert_equal "group ##{g.id}", g.display_name
  end
  
  def test_habtm_contacts
    brainhouse = Group.find(groups(:brainhouse).id)
    assert_not_nil brainhouse.contacts
    assert_equal 2, brainhouse.contacts.size
    brainhouse.contacts.each {|contact|
      subtest_contact contact
    }
    assert brainhouse.contacts.include?(contacts(:renat))
    assert brainhouse.contacts.include?(contacts(:yura))
    assert !brainhouse.contacts.include?(contacts(:thomas))
  end
  
  def test_bt_addresses
    g = Group.find(groups(:brainhouse).id)
    assert_not_nil g.shipping_address
    assert_equal 1, g.shipping_address.id
    assert_not_nil g.billing_address
    assert_equal 2, g.billing_address.id
  end

  def test_bt_group_type
    g = Group.find(groups(:brainhouse).id)
    assert_not_nil g.group_type
    assert_equal 2, g.group_type.id
  end

  def test_hierarchical
    assert Group.hierarchical?
    assert Group.find(:first).hierarchical?
  end

  def test_searchable
    assert !Group.find(:first).searchable?
    assert !Group.searchable?
  end

  def test_emailable
    assert !Group.find(:first).emailable?
    assert !Group.emailable?
  end

  def test_taggable
    assert Group.find(:first).taggable?
    assert Group.taggable?
  end

  def subtest_contact(contact)
    assert_instance_of Contact, contact
    assert_valid contact
    assert contact.errors.empty?
  end
end
