
def write_to_file(path, content)
    File.open(path, 'w') do |f|
        f.write(content)
        f.close()
    end
end