require "utils/logger"
require 'utils/proxy_manager'

module MiMOWheel
    class Action 
        include MiMOWheelLogger
        include MiMOWheelProxyManager
        def fire(args)
            info("start fire 🚀")
            check_and_fire(args)
        end
    end
end