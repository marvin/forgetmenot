# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 13) do

  create_table "activities", :force => true do |t|
    t.column "activity_type_id", :integer
    t.column "time",             :datetime
    t.column "notes",            :text
  end

  create_table "activities_contacts", :id => false, :force => true do |t|
    t.column "activity_id", :integer
    t.column "contact_id",  :integer
  end

  create_table "activity_types", :force => true do |t|
    t.column "name", :string
  end

  create_table "addresses", :force => true do |t|
    t.column "address1", :string
    t.column "address2", :string
    t.column "city",     :string
    t.column "state",    :string
    t.column "zip",      :string
    t.column "country",  :string
  end

  create_table "contacts", :force => true do |t|
    t.column "first_name",     :string
    t.column "last_name",      :string
    t.column "email",          :string
    t.column "phone_number",   :string
    t.column "title",          :string
    t.column "work_phone",     :string
    t.column "mobile_phone",   :string
    t.column "home_phone",     :string
    t.column "other_phone",    :string
    t.column "fax",            :string
    t.column "do_not_email",   :boolean
    t.column "do_not_phone",   :boolean
    t.column "notes",          :text
    t.column "address_id",     :integer
    t.column "address2_id",    :integer
    t.column "lead_source_id", :integer
  end

  create_table "contacts_groups", :id => false, :force => true do |t|
    t.column "contact_id", :integer
    t.column "group_id",   :integer
  end

  create_table "group_types", :force => true do |t|
    t.column "name", :string
  end

  create_table "groups", :force => true do |t|
    t.column "name",                :string
    t.column "account_number",      :integer
    t.column "phone",               :string
    t.column "fax",                 :string
    t.column "website",             :string
    t.column "notes",               :text
    t.column "billing_address_id",  :integer
    t.column "shipping_address_id", :integer
    t.column "group_type_id",       :integer
    t.column "parent_id",           :integer
    t.column "lft",                 :integer
    t.column "rgt",                 :integer
  end

  create_table "lead_sources", :force => true do |t|
    t.column "name", :string
  end

end
