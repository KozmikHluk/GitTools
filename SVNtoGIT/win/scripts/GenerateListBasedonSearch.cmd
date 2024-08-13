#generate customer list

svn log "https://devsvn/svn/tcs" -v --search "*Models/IDLog*" | find "/trunk/*/P"