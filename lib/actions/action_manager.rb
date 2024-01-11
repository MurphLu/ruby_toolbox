require 'actions/git_tools'
require 'actions/clash_tools'
require 'actions/ffmpeg_tools'
require 'actions/pdf_tools'
require 'actions/test_tool'

module MiMOWheel
    
    class ActionManager
        class << self
            @@actions = {
                    "git" => MiMOWheel::GitTools.new,
                    "clashX" => MiMOWheel::ClashTools.new,
                    "video" => MiMOWheel::FFmpegTools.new,
                    "pdf" => MiMOWheel::PdfTools.new,
                    "test" => MiMOWheel::TestTool.new
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