require 'yaml'
require './util/path_getter.rb'
require './util/file_editor.rb'

path = Dir.glob(user_path+'/.config/clash/*-*-*.yaml')[0]
if path
    yaml = YAML.load_file(path)
    rules = yaml['rules']
    newRules = [];
    rules.each do |e|
        arr = e.split(',')
        if ['baidu', 'bdimg.com', 'bdstatic.com'].index(arr[1])
            arr[2] = 'Proxy'
            newRules.push(arr.join(','))
        else
            newRules.push(e)
        end
    end
    yaml['rules'] = newRules
    write_to_file(path, yaml.to_yaml)
else
    puts "not a file"
end
