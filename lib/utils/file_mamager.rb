module MiMOWheel
    class FileNamager
        class << self
            def write_to_file(path, content)
                File.open(path, 'w') do |f|
                    f.write(content)
                    f.close()
                end
            end
        end
    end
end