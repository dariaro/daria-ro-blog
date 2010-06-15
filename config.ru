require 'toto'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

#use Rack::ShowExceptions
#if ENV['RACK_ENV'] == 'development'
# use Rack::ShowExceptions
#end

# Run application
toto = Toto::Server.new do
  
  set :author, "Дарья Росюк"
  set :title, "Дарья Росюк"
  set :date, lambda {|now| now.strftime("%d %b %Y") }
  set :ext, "txt"
  set :url, 'http://dariaro.com'
  set :root, "index"                           # page to load on /
  set :markdown, :smart                        # use markdown + smart-mode
  set :summary, :max => 1000, :delim => /~\n/  # length of article summary and delimiter
  set :disqus, "daria-ro-blog"          # disqus id, or false
  set :cache, 28800                     # cache duration, in seconds
end

# Redirect www to non-www
#gem 'rack-rewrite', '~> 0.2.1'
#require 'rack-rewrite'
#  if ENV['RACK_ENV'] == 'production'
#    use Rack::Rewrite do
#      r301 %r{.*}, 'http://dariaro.com$&', :if => Proc.new  do |rack_env|
#        rack_env['SERVER_NAME'] != 'dariaro.com'
#      end
#    end
#end

run toto

