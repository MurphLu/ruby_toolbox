require 'actions/git_tools'
require 'actions/clash_tools'
require 'actions/ffmpeg_tools'

module MiMOWheel
    
    class ActionManager
        class << self
            @@actions = {
                    "git" => MiMOWheel::GitTools.new,
                    "clashX" => MiMOWheel::ClashTools.new,
                    "video" => MiMOWheel::FFmpegTools.new
            }

            def get_action_module(action)
                if @@actions.has_key?(action)
                    return @@actions.fetch(action)
                else
                    return nil
                end
            end
        end
    end
end