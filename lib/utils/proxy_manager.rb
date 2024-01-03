module MiMOWheel
    class ProxyManager
        class << self
            def check_and_set_proxy
                clash_running_flag=`lsof -i tcp:7890 | grep ClashX | grep LISTEN | wc -l`
                if clash_running_flag.strip == '0'
                    puts "proxy not running"
                    return
                end
                puts 'proxy running'
                puts 'set proxy to env'

                ENV['http_proxy'] = 'http://127.0.0.1:7890'
                ENV['https_proxy'] = 'http://127.0.0.1:7890'
                ENV['all_proxy'] = 'socks5://127.0.0.1:7890'

                puts '--- set proxy success'

                puts formatted_log("end check and set proxy")
            end

            def unset_proxy
                ENV.delete('http_proxy')
                ENV.delete('https_proxy')
                ENV.delete('all_proxy')
                puts '--- unset proxy finish'
            end

            def formatted_log(log)
                log_len = 68
                str = '===================================================================='
                prefix_suffix_len = (68 - log.length) / 2
                prefix_suffix = str[0, prefix_suffix_len];
                formatted = "#{prefix_suffix} #{log} #{prefix_suffix}"
                return formatted
            end
        end
    end
end