require "colored"

module MiMOWheelLogger
    def info(msg)
        puts "[INFO] [#{Time.new}] #{msg}".green
    end

    def err(msg)
        puts "[ERROR] [#{Time.new}] #{msg}".red
    end
end