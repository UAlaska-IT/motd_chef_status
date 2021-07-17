# frozen_string_literal: true

provides :motd_fragment
unified_mode true

property :fragment_name, [String, nil]
property :template_cookbook, String, required: true
property :template_source, String, required: true
property :template_variables, Hash, default: {}

default_action :create

action :create do
  directory fragment_directory do
    owner 'root'
    group 'root'
    mode '0755'
  end
  template_name = if new_resource.fragment_name.nil?
                    new_resource.name
                  else
                    new_resource.fragment_name
                  end
  template fragment_directory + template_name do
    cookbook new_resource.template_cookbook
    source new_resource.template_source
    variables new_resource.template_variables
    group node['root_group']
    owner 'root'
    mode '0755'
    action :create
  end
end

action :delete do
  template_name = if new_resource.fragment_name.nil?
                    new_resource.name
                  else
                    new_resource.fragment_name
                  end
  every_fragment_directory.each do |dir|
    file dir + template_name do
      action :delete
    end
  end
end
