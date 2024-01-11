require 'actions/action'
require 'utils/proxy_manager'

module MiMOWheel
    class GitTools < Action
        def check_and_fire(args)
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
            MiMOWheel::ProxyManager.unset_proxy()
            # command = add_command + commit_command + push_command
            # return command
        end

        def check_and_set_proxy
            git_remote_url_github_flag=`git remote get-url --all origin | grep github.com | wc -l`
            if git_remote_url_github_flag.strip == '0'
                info("no github remote skip set proxy")
                return 
            end
            info('remote is github')
            MiMOWheel::ProxyManager.check_and_set_proxy()
        end

        def unset_proxy
            ENV.delete('http_proxy')
            ENV.delete('https_proxy')
            ENV.delete('all_proxy')
        end

        def check_and_run_add(comment)
            info('step 1. check if need add')
            add_status=`git status | egrep 'Changes not staged for commit|Untracked files' | wc -l`
            if add_status.strip == '0'
                info('---- git add not need')
                return
            end
            if system('git add .')
                info('---- git add success')
            else
                info('---- git add fail')
            end
        end

        def check_and_run_commit(comment)
            info('step 2. check if need commit')
            commit_status=`git status | grep 'Changes to be committed' | wc -l`
            if commit_status.strip == '0'
                info('---- git commit not need')
                return
            end
            if system("git commit -m '#{comment}'")
                info('---- git commit success')
            else
                info('---- git commit fail')
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