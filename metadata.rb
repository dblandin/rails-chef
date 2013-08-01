name              'devon-rails'
maintainer        'Devon Blandin'
maintainer_email  'dblandin@gmail.com'
license           'MIT'
description       'Installs and configures a rails server'
version           '0.0.1'

recipe 'devon-rails', 'Installs and configures a rails server'

%w{ ubuntu }.each do |os|
  supports os
end

%w{ build-essential openssl nginx runit postgresql unicorn tmux vim }.each do |cookbook|
  depends cookbook
end
