require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class WordpressInstall < Chef::Provider::LWRPBase
      include Wordpress::Helpers

      action :create do

        if new_resource.create_path_if_missing
          directory new_resource.install_path do
            owner new_resource.owner
            group new_resource.group
            recursive true
            not_if { ::Dir.exists?(new_resource.install_path) }
            action :create
          end
        end

        if new_resource.install_method == 'git'
          install_git_dependencies

          if new_resource.install_source
            source = new_resource.install_source
          else
            source = 'https://github.com/WordPress/WordPress.git'
          end

          git new_resource.install_path do
            repository source
            reference new_resource.reference
            user new_resource.owner
            group new_resource.group
          end

        elsif new_resource.install_method == 'tarball'
          if new_resource.install_source
            source = new_resource.install_source
          else
            source = "https://wordpress.org/wordpress-#{new_resource.version}.tar.gz"
          end
          print new_resource.owner
          print new_resource.group

          tar_extract source do
            target_dir new_resource.install_path
            user new_resource.owner
            group new_resource.group
            tar_flags ['--strip-components 1', '--no-same-owner']
            not_if { ::File.exist?(::File.join(new_resource.install_path, 'index.php')) }
          end
        end
      end
    end
  end
end
