require 'actions/action'
require 'yaml'

module MiMOWheel
    class FFmpegTools < Action
        def check_and_fire(args)
            index = args("-url")
            if !index.nil?
                url = args[index+1]
                down_load_video(url)
            end
        end

        def down_load_video(url)
            system("ffmpeg -i '#{url}' -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 #{Time.now.to_i}.mp4")
        end

    end
end