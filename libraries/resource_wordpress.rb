require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class WordpressInstall < Chef::Resource::LWRPBase
      self.resource_name = :wordpress_install
      actions :create
      default_action :create

      attribute :install_method, kind_of: String,
                                 equal_to: %w(tarball zip git),
                                 default: 'tarball'
      attribute :install_path, kind_of: String, default: '/var/www/wordpress'
      attribute :create_path_if_missing, kind_of: [TrueClass, FalseClass],
                                         default: true
      attribute :install_source, kind_of: String, default: nil
      # Attribute :version is only used with tarball and zip installations
      attribute :version, kind_of: String, default: 'latest'
      # Attribute :reference is only used when leveraging git
      attribute :reference, kind_of: String, default: 'master'
      attribute :owner, kind_of: String, default: 'root'
      attribute :group, kind_of: String, default: 'root'
    end
  end
end
