# frozen_string_literal: true

provides :motd_fragment

property :fragment_name, String, name_property: true
property :template_cookbook, String, required: true
property :template_source, String, required: true
property :template_variables, Hash, default: {}

default_action :create

action :create do
  template fragment_directory + new_resource.fragment_name do
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
  file fragment_directory + new_resource.fragment_name do
    action :delete
  end
end
