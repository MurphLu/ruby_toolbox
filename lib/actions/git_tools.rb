require 'actions/action'

module MiMOWheel
    class GitTools < Action
        def check_and_fire(args)
            puts args
            params = anaylaze_params(args)
            command = build_command(params[0], params[1], params[2], params[3])
            exec_command(command)
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
        
        def build_command(need_add, need_commit, need_push, comment)
            proxy_command = check_and_set_proxy()
            add_command = need_add ? add_command(comment) : ""
            commit_command = need_commit ? commit_command(comment) : ""
            push_command = need_push ? push_command(comment) : ""
            command = proxy_command + add_command + commit_command + push_command
            return command
        end

        def check_and_set_proxy
            return command = "
                echo #{formatted_log("start git action pre check and if set proxy")}
                if git remote get-url --all origin | grep github.com; then
                    echo 'remote is github.com'
                    echo #{formatted_log("check and set proxy")}
                    clashX=`lsof -i tcp:7890 | grep ClashX | grep LISTEN | wc -l | sed -e 's/^[ \t]*//g'`
                    if test $clashX -gt 0; then
                        echo '--- ClashX is running'
                        export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
                        echo '--- set proxy success'
                        echo 'detail: '
                        printf '\t http_proxy: %s \n' $http_proxy
                        printf '\t https_proxy: %s \n' $https_proxy
                        printf '\t all_proxy: %s \n' $all_proxy
                    else
                        echo 'ClashX is not running'
                    fi
                    echo #{formatted_log("end check and set proxy")}
                fi
            "
        end

        def add_command(comment)
            return command = "
                echo #{formatted_log("start git action with comment: #{comment}")}
                echo 'step 1. check if need add'
                stage_status=`git status | grep 'Changes not staged for commit' | wc -l | sed -e 's/^[ \t]*//g'`
                if test $stage_status -gt 0; then
                    if git add .; then
                        echo '---- git add success'
                    fi
                else
                    echo '---- git add not need'
                fi
            "
        end

        def commit_command(comment)
            return command = "
                echo 'step 2. check if need commit'
                commit_status=`git status | grep 'Changes to be committed' | wc -l | sed -e 's/^[ \t]*//g'`
                if test $commit_status -gt 0; then
                    if git commit -m '#{comment}'; then
                        echo '--- git commit success'
                    fi
                else
                    echo '--- git commit not need'
                fi
            "
        end

        def push_command(comment)
            return command = "
                echo 'step 3. check if need push'
                push_status=`git status | grep 'Your branch is ahead of' | wc -l | sed -e 's/^[ \t]*//g'`
                if test $push_status -gt 0; then
                    if git push; then
                        echo '---- git push success'
                    fi
                else
                    echo '--- git push not need'
                fi
                echo #{formatted_log("finish git action with comment: #{comment}")}
            "
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