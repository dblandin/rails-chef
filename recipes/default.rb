%w(git-core zsh).each do |a_package|
  package a_package
end

%w(build-essential openssl tmux vim runit postgresql postgresql::server postgresql::ruby nginx::source unicorn).each do |recipe|
  include_recipe recipe
end

username = node[:user][:name]

user username do
  password node[:user][:password]
  gid 'sudo'
  home "/home/#{username}"
  supports manage_home: true
  shell '/bin/zsh'
end

template "/home/#{username}/.zshrc" do
  source "zshrc.erb"
  owner username
end

directory "/home/#{username}/example" do
  owner username
end

file "/home/#{username}/example/index.html" do
  owner username
  content '<h1>Hello World</h1>'
end

file "/home/#{username}/.gemrc" do
  content 'gem: --no-ri --no-rdoc'
end

file "#{node[:nginx][:dir]}/sites-available/example" do
  content "server { root /home/#{username}/example; }"
end

nginx_site 'example'
