require 'actions/action'

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
            check_to_set_proxy()
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

            info("👏👏👏 congratulations!!! run success")
            # command = add_command + commit_command + push_command
            # return command
        end

        def check_to_set_proxy
            git_remote_url_github_flag=`git remote get-url --all origin | grep github.com | wc -l`
            if git_remote_url_github_flag.strip == '0'
                info("no github remote skip set proxy")
                return 
            end
            info('remote is github')
            check_and_set_proxy()
        end

        def check_and_run_add(comment)
            info('step 1. check if need add')
            add_status=`git status | egrep 'Changes not staged for commit|Untracked files' | wc -l`
            if add_status.strip == '0'
                info('---- git add not need')
                return
            end
            if exec_command('git add .')
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
            if exec_command("git commit -m '#{comment}'")
                info('---- git commit success')
            else
                info('---- git commit fail')
            end
        end

        def check_and_run_push(comment)
            info('step 3. check if need push')
            commit_status=`git status | grep 'Your branch is ahead of' | wc -l`
            if commit_status.strip == '0'
                info('---- git push not need')
                return
            end
            
            if exec_command("git push")
                info('---- git push success')
            else
                info('---- git push fail')
            end
            info("finish git action with comment: #{comment}")
        end

        def exec_command(command)
            command("call command: #{command}")
            return system(command)
        end
    end
end 