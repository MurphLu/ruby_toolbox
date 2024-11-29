module MiMOWheel
    class FileNamager
        class << self
            def write_to_file(path, content)
                File.open(path, 'w') do |f|
                    f.write(content)
                    f.close
                end
            end

            def get_file_list(ext)
                path = Dir.pwd
                
            end
        end
    end
end