#
# Cookbook Name:: terraform
# Recipe:: default
#
# Copyright 2016, Opex Software
#
# All rights reserved - Do Not Redistribute
#
bash 'get terraform zip' do
  cwd '/tmp'
  code <<-EOH
     wget #{node['terraform']['Terraform_Zip_Url']} --no-check-certificate
    EOH
  not_if { ::File.exists?("/tmp/#{node['terraform']['Terraform_Zip_Name']}") }
end

package "unzip"

bash "Unzip terraform zip to install terraform" do
  cwd "/tmp"
    code <<-EOH
     unzip #{node['terraform']['Terraform_Zip_Name']} -d /usr/local/bin/
  EOH
  not_if "ls /usr/local/bin/terraform"
end
