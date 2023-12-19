require 'actions/action_manager'

module MiMOWheel
    class CLIToolsDistributor
        class << self
            def take_off
                check_make_action(ARGV.first)
            end

            def check_make_action(action)
                result = MiMOWheel::ActionManager.get_action_module(action)
                if result != nil
                    result.fire(ARGV);
                else
                    puts "mimowheel action #{action} not found"
                end
            end
        end
    end
end
