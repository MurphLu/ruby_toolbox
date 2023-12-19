require 'cli_tools_distributor'

module MiMOWheel
    class ToolBox
        class << self
            def fire
                MiMOWheel::CLIToolsDistributor.take_off()
            end
        end
    end
end