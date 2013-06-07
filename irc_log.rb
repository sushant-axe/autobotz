require 'sinatra'
require 'redis'
set :environment, :production #For ip:4567 , comment this to get localhost:4567
redis = Redis.new(:host => '127.0.0.1', :port => 6379)
get '/' do
	len = redis.LLEN 'msg'
	data = redis.lrange('msg',0,len)
	data.reverse.join("<br />")
end

end