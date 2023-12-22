require 'actions/action'

module MiMOWheel
    class GitTools < Action
        def check_and_fire(args)
            puts args
            params = anaylaze_params(args)
            exec(params[0], params[1], params[2], params[3])
            # exec_command(command)
            # exec()
        end

        def anaylaze_params(args) 
              command = get_command(args)
              need_add = command == nil ? true : command.include?("a")
              need_commit = command == nil ? true : command.include?("c")
              need_push = command == nil ? true : command.include?("p")
              comment = args[-1]
              params = [need_add, need_commit, need_push, comment]
              return params
        end

        def get_command(args)
            args.each do |arg|
                if arg.include?("-")
                    return arg
                end
            end 
            return nil 
        end
        
        def exec(need_add, need_commit, need_push, comment)
            check_and_set_proxy()
            if need_add 
                check_and_run_add(comment)
            end
            if need_commit
                check_and_run_commit(comment)
            end
            if need_push
                check_and_run_push(comment)
            end
            unset_proxy()
            # command = add_command + commit_command + push_command
            # return command
        end

        def check_and_set_proxy
            git_remote_url_github_flag=`git remote get-url --all origin | grep github.com | wc -l`
            if git_remote_url_github_flag.strip == '0'
                puts "no github remote skip set proxy"
                return 
            end
            puts 'remote is github'
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
        end

        def check_and_run_add(comment)
            puts 'step 1. check if need add'
            add_status=`git status | grep 'Changes not staged for commit' | wc -l`
            if add_status.strip == '0'
                puts '---- git add not need'
                return
            end
            if system('git add .')
                puts '---- git add success'
            else
                puts '---- git add fail'
            end
        end

        def check_and_run_commit(comment)
            puts 'step 2. check if need commit'
            commit_status=`git status | grep 'Changes to be committed' | wc -l`
            if commit_status.strip == '0'
                puts '---- git commit not need'
                return
            end
            if system("git commit -m '#{comment}'")
                puts '---- git commit success'
            else
                puts '---- git commit fail'
            end
        end

        def check_and_run_push(comment)
            puts 'step 3. check if need push'
            commit_status=`git status | grep 'Your branch is ahead of' | wc -l`
            if commit_status.strip == '0'
                puts '---- git push not need'
                return
            end
            if system("git push")
                puts '---- git push success'
            else
                puts '---- git push fail'
            end
            puts formatted_log("finish git action with comment: #{comment}")
        end

        def exec_command(command)
            system(command)
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