require 'actions/action'
require 'utils/file_mamager'

module MiMOWheel
    class ClashTools < Action
        def check_and_fire(args)
            if args.include?("-us")
                up_us_config()
            end
        end

        def up_us_config
            user_path = File.expand_path('~')
            path = Dir.glob(user_path+'/.config/clash/*-*-*.yaml')[0]
            path_us = Dir.glob(user_path+'/.config/clash/us.yaml')[0]
            if path
                yaml = YAML.load_file(path)
                proxies = yaml['proxies']
                yaml_us = YAML.load_file(path_us)
                proxies_us = []
                proxies.each do |proxy|
                    if(proxy['name'].index('UnitedStates') == 0)
                        proxies_us.push(proxy)
                    end
                end
                yaml_us['proxies'] = proxies_us
                MiMOWheel::FileNamager.write_to_file(path_us, yaml_us.to_yaml)
            end
            info("update us proxies success")
        end
    end
end