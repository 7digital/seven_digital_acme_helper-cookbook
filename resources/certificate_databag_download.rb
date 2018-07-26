default_action :sync

property :certificate_name, [String], name_property: true
property :data_bag_name, [String]
property :data_bag_secret, [String]
property :crt,        [String, nil], default: nil
property :key,        [String, nil], default: nil
property :chain,      [String, nil], default: nil
property :fullchain,  [String, nil], default: nil
property :owner,  [String, nil], default: nil
property :group,  [String, nil], default: nil

action :sync do
  data_bag_secret = IO.read(new_resource.data_bag_secret)
  data_bag_contents = data_bag_item(new_resource.data_bag_name, new_resource.certificate_name, data_bag_secret)

  unless new_resource.key.nil?
    file new_resource.key do
      content data_bag_contents['key']
      sensitive true
      owner new_resource.owner
      group new_resource.group
    end
  end
  unless new_resource.crt.nil?
    file new_resource.crt do
      content data_bag_contents['crt']
      sensitive true
      owner new_resource.owner
      group new_resource.group
    end
  end
  unless new_resource.chain.nil?
    file new_resource.chain do
      content data_bag_contents['chain']
      sensitive true
      owner new_resource.owner
      group new_resource.group
    end
  end
  unless new_resource.fullchain.nil?
    file new_resource.fullchain do
      content data_bag_contents['fullchain']
      sensitive true
      owner new_resource.owner
      group new_resource.group
    end
  end
end
