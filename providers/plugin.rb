
def whyrun_supported?
  true
end

action :install do

  if @current_resource.exists
    Chef::Log.info "Plugin #{@new_resource} already exists - nothing to do."
  else
    converge_by("Add plugin #{@new_resource}") do
      add_plugin
    end
  end
end

def add_plugin
  # Retrieve the file
  remote_file "#{Chef::Config[:file_cache_path]}/#{new_resource.plugin_name}.zip" do
    source url
  end
  
  # TODO: update/freshen the files in the plugins directory
  bash "install-plugin" do
    cwd "#{node['wordpress']['dir']}/wp-content/plugins"
    code "temp=(mktemp -d) && unzip -d $temp #{Chef::Config[:file_cache_path]}/#{new_resource.plugin_name}.zip && mkdir #{name} && mv $temp/*/* #{name} && rmdir $temp/* $temp"
  end
end

def load_current_resource
  @current_resource = Chef::Resource::WordpressPlugin.new(@new_resource.name)
  @current_resource.name(@new_resource.name)
  @current_resource.plugin_name(@new_resource.plugin_name)
  @current_resource.url(@new_resource.url)

  if plugin_exists?(@current_resource.plugin_name)
    @current_resource.exists = true
  end

  @current_resource
end

def plugin_exists?(name)

  if Dir.exist?("#{node['wordpress']['dir']}/wp-content/plugins/#{name}")
    return true
  end

  return false
end

