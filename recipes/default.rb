#
# Cookbook Name:: goiardi
# Recipe:: default
#
# Copyright (C) 2015 Matt Whiteley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file "/usr/bin/goiardi" do
  source node[:goiardi][:bin]
  mode "0755"
end

directory node[:goiardi][:rundir] do
  mode "0700"
  owner "root"
  group "root"
end

directory "#{node[:goiardi][:rundir]}/file_checksums" do
  mode "0700"
  owner "root"
  group "root"
end

template node[:goiardi][:config] do
  source "goiardi.conf.erb"
  mode "0444"
  owner "root"
  group "root"
  variables({
    :store => node[:goiardi][:rundir],
    :objsize => 104857600,
    :jsonsize => 104857600,
    :freezeint => 300
  })
end
