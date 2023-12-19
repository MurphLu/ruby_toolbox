require 'actions/git_tools'

module MiMOWheel
    
    class ActionManager
        class << self
            @@actions = {
                    "git" => MiMOWheel::GitTools.new,
                    "clashX" => ["up", "us"],
            }

            def get_action_module(action)
                puts @@actions
                if @@actions.has_key?(action)
                    return @@actions.fetch(action)
                else
                    return nil
                end
            end
        end
    end
end