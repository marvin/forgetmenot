# Author:: Renat Akhmerov (mailto:renat@brainhouse.ru)
# Author:: Yury Kotlyarov (mailto:yura@brainhouse.ru)
# License:: MIT License

require 'maruku'

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  SKIP_TABLE_LIST = %w{ schema_info taggings tags dynamic_attribute_values }
  def get_table_names
    ActiveRecord::Base.establish_connection
    (ActiveRecord::Base.connection.tables - SKIP_TABLE_LIST).select {|table|
      !ActiveRecord::Base.connection.columns(table).select { |column| column.name == 'id' }.empty?
    }
  end
  
  def referer
    if request.env['HTTP_REFERER'] =~ /\/(\w+)\/show\/(\d+)$/
      $1.classify.constantize.find($2)
    end 
  end
  
  def markdown(string)
    Maruku.new(string).to_html
  end

  # methods for hierarchical entities support
 
  # FIXME cleanup obsolete code

  # def get_hierarchy(entity_class)
  #   content_tag(:ul, 
  #     entity_class.find(:all, :conditions => 'parent_id IS NULL or parent_id = 0', :order => 'root_id, lft').collect {|root|
  #       get_subtree(root) }.join)
  # end
  
  # def get_subtree(node)
  #   debugger
  #   dn = node.display_name
  #   cn = node.class.name.tableize
  #   nid = node.id
  #   ndch = node.direct_children
  #   content_tag(:li, 
  #     %Q{#{link_to node.display_name, :controller => node.class.name.tableize, :action => 'list', :parent_id => node.id} \
  #     #{node.direct_children.collect {|child| content_tag(:ul, get_subtree(child))}.join}}.gsub(/\s{2,}/, "")  # TODO why is it trimming double-spaces?
  #   )
  # end
  
  def breadcrumbs(object)
    return "" unless object.hierarchical? && !object.lft.nil?
    (entity_class.find(:all, { :conditions => "root_id = #{object.root_id} AND (#{object.lft} BETWEEN lft AND rgt)", :order => "lft" }) - [object]).collect { |e|
      link_to e.display_name, :id => e.id
    }.push(object.display_name).join(" > ")
  end
  
  def get_dynamic_attribute_type_names
    DynamicAttributeValue.content_columns.collect { |c| $1 if c.name =~ /(\w+)_value/ }.compact
  end
  		
end
