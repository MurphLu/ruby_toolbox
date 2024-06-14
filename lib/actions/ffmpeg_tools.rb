require 'actions/action'
require 'yaml'

module MiMOWheel
    class FFmpegTools < Action
        def check_and_fire(args)
            url_index = args.index("-url")
            if !url_index.nil?
                url = args[index+1]
                down_load_video(url)
            end
            db = get_arg(args, "-dB")
            file = get_arg(args, "-i")
            if !db.nil? && !file.nil?
                change_media_db(file, db)
            end
        end

        def change_media_db(file, db)
            system("ffmpeg -i '#{file}' -filter:a \"volume='#{db}dB'\" 'new_#{file}'")
        end

        def get_arg(args, name)
            idx = args.index(name)
            if !idx.nil?
                return args[idx+1]
            end
            return nil
        end
        def down_load_video(url)
            system("ffmpeg -i '#{url}' -bsf:a aac_adtstoasc -vcodec copy -c copy -crf 50 #{Time.now.to_i}.mp4")
        end

    end
end