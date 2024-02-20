require "utils/logger"

module MiMOWheelProxyManager
    include MiMOWheelLogger
    def check_and_set_proxy
        clash_running_flag=`lsof -i tcp:7890 | grep ClashX | grep LISTEN | wc -l`
        if clash_running_flag.strip == '0'
            puts "proxy not running"
            return
        end
        info('proxy running')
        info('set proxy to env')

        ENV['http_proxy'] = 'http://127.0.0.1:7890'
        ENV['https_proxy'] = 'http://127.0.0.1:7890'
        ENV['all_proxy'] = 'socks5://127.0.0.1:7890'

        info('--- set proxy success')

        info("end check and set proxy")
    end

    def unset_proxy
        ENV.delete('http_proxy')
        ENV.delete('https_proxy')
        ENV.delete('all_proxy')
        info('--- unset proxy finish')
    end
end