require 'git_tools'

module MiMO
    class Test
        class << self
            def main(arg)
                MiMO::GitTools.check()
            end
        end
    end
end