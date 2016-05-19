#
# Cookbook Name:: terraform
# Recipe:: default
#
# Copyright 2016, Opex Software
#
# All rights reserved - Do Not Redistribute
#
directory '/root/terraform' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file "/root/terraform/#{node['terraform']['Terraform_Zip_Name']}" do
  source node['terraform']['Terraform_Zip_Url']
  action :create
end

bash "Unzip terraform zip to install terraform" do
  cwd "/root/terraform"
    code <<-EOH
     unzip #{node['terraform']['Terraform_Zip_Name']}
  EOH
  not_if "ls /root/terraform/terraform"
end

ruby_block "export Path in /root/.bashrc file" do
  block do
    file = Chef::Util::FileEdit.new("/root/.bashrc")
    file.insert_line_if_no_match("/export PATH=$PATH:/root/terraform/", "export PATH=$PATH:/root/terraform")
    file.write_file
  end
end
