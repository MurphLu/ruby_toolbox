require "utils/logger"

module MiMOWheel
    class Action 
        include MiMOWheelLogger
        def fire(args)
            info("start fire 🚀")
            check_and_fire(args)
        end
    end
end