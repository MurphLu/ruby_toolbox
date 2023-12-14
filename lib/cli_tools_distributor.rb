module MiMO
    class CLIToolsDistributor
        class << self
            def take_off
                puts ARGV
                ARGV.first
            end
        end
    end
end
