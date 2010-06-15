require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger
#use Rack::ShowExceptions
if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

# Run application
toto = Toto::Server.new do
  
  set :author, "Дарья Росюк"
  set :title, "Дарья Росюк"
  set :date, lambda {|now| now.strftime("%d %b %Y") }
  set :ext, "txt"
  set :url, 'http://daria-ro-blog.heroku.com'
  set :root, "index"                           # page to load on /
  set :markdown, :smart                        # use markdown + smart-mode
  set :summary, :max => 1000, :delim => /~\n/  # length of article summary and delimiter
#  set :disqus, "daria-ro-blog"                # disqus id, or false
  set :disqus, "disqus_developer = 1"          # disqus id, or false
  # set :cache,      28800                     # cache duration, in seconds
end

# Redirect non-www to www
# gem 'rack-rewrite', '~> 0.2.1'
# require 'rack-rewrite'
# 	if ENV['RACK_ENV'] == 'production'
# 		use Rack::Rewrite do
# 		  r301 %r{.*}, 'http://daria-ro-blog.heroku.com$&', :if => Proc.new {|rack_env|
# 		  rack_env['SERVER_NAME'] != 'http://daria-ro-blog.heroku.com'
# 		}
# 	end
# end

run toto

