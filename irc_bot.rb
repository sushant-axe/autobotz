require 'cinch'
require 'redis'


bot = Cinch::Bot.new do
  redis = Redis.new(:host => '127.0.0.1', :port => 6379)
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#nitk-autobotz"]
    c.nick = 'autobotz'
  end

  on :message do |m|
    redis.LPUSH 'msg', m.user.nick+": "+(m.params[1]).to_s
  end

  on :message,"!hello" do |m|
    m.reply("Hello #{m.user.nick}")
    redis.LPUSH 'msg', "autobotz"+": "+"Hello #{m.user.nick}"
  end

  on :message,"!log" do |m|
    m.reply("#{m.user.nick}: The log can be found in http://106.186.21.37:4567/")
    redis.LPUSH 'msg' , "autobotz"+": "+"#{m.user.nick}The log can be found in http://106.186.21.37:4567/"
  end

end
bot.start