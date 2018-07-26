default_action :sync

property :certificate_name, [String], name_property: true
property :data_bag_name, [String]
property :data_bag_secret, [String]
property :certificate, [String]
property :crt,        [String, nil], default: nil
property :key,        [String, nil], default: nil
property :chain,      [String, nil], default: nil
property :fullchain,  [String, nil], default: nil

action :sync do
  key_content = new_resource.key.nil? ? '' : ::File.read(new_resource.key)
  crt_content = new_resource.crt.nil? ? '' : ::File.read(new_resource.crt)
  chain_content = new_resource.chain.nil? ? '' : ::File.read(new_resource.chain)
  fullchain_content = new_resource.fullchain.nil? ? '' : ::File.read(new_resource.fullchain)

  data_bag_item_name = new_resource.certificate_name.gsub(/[^a-zA-Z\-_0-9]/, '_')
  certificate_databag_item = data_bag_item(new_resource.data_bag_name, new_resource.data_bag_name)
  certificate_databag_item[data_bag_item_name] = {}
  certificate_databag_item[data_bag_item_name]['key'] = key_content
  certificate_databag_item[data_bag_item_name]['crt'] = crt_content
  certificate_databag_item[data_bag_item_name]['chain'] = chain_content
  certificate_databag_item[data_bag_item_name]['fullchain'] = fullchain_content

  begin
    certificate_databag_item.save
  rescue StandardError => err_result
    log 'Cert upload' do
      message "Failed uploading cert for #{data_bag_item_name} to databag #{new_resource.data_bag_name} using secret #{new_resource.data_bag_secret}\n#{err_result}"
      level :fatal
    end
  end
end
