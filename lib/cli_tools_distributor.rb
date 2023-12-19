require 'actions/action_manager'

module MiMOWheel
    class CLIToolsDistributor
        class << self
            def take_off
                puts ARGV
                check_make_action(ARGV.first)
            end

            def check_make_action(action)
                result = MiMOWheel::ActionManager.get_action_module(action)
                result.fire(ARGV);
            end
        end
    end
end
