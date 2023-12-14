require 'git_tools'

module MiMO
    class MRT
        class << self
            def fire
                MiMO::CLIToolsDistributor.take_off()
            end
        end
    end
end