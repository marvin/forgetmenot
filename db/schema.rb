# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 6) do

  create_table "activities", :force => true do |t|
    t.column "activity_type_id", :integer
    t.column "occured_at",       :datetime
    t.column "description",      :string
  end

  create_table "activities_contacts", :id => false, :force => true do |t|
    t.column "activity_id", :integer
    t.column "contact_id",  :integer
  end

  create_table "activity_types", :force => true do |t|
    t.column "name", :string
  end

  create_table "contacts", :force => true do |t|
    t.column "first_name",   :string
    t.column "last_name",    :string
    t.column "email",        :string
    t.column "phone_number", :string
  end

  create_table "contacts_groups", :id => false, :force => true do |t|
    t.column "contact_id", :integer
    t.column "group_id",   :integer
  end

  create_table "groups", :force => true do |t|
    t.column "name", :string
  end

end
