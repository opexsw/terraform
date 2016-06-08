#
# Cookbook Name:: terraform
# Recipe:: default
#
# Copyright 2016, Opex Software
#
# All rights reserved - Do Not Redistribute
#

remote_file "/tmp/#{node['terraform']['Terraform_Zip_Name']}" do
  source node['terraform']['Terraform_Zip_Url']
  action :create
end

package "unzip"

bash "Unzip terraform zip to install terraform" do
  cwd "/tmp"
    code <<-EOH
     unzip #{node['terraform']['Terraform_Zip_Name']} -d /usr/local/bin/
  EOH
  not_if "ls /usr/local/bin/terraform"
end
