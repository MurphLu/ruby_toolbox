
ENV["http_proxy"] = "http://127.0.0.1:7890"
ENV["https_proxy"] = "http://127.0.0.1:7890"
system('echo $http_proxy')
system('ping www.google.com')