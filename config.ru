require 'toto'
require 'haml'

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

toto = Toto::Server.new do
  
  set :author, "Daria Rosyuk"
  set :title, "Daria's place"
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :ext, "txt"
  set :url,     'http://daria-ro-blog.heroku.com'
  set :root,      "index"                                   # page to load on /
  set :markdown,  :smart                                    # use markdown + smart-mode
  set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :disqus,    false                                     # disqus id, or false
  # set :cache,      28800                                    # cache duration, in seconds
  set :to_html do |path, page, ctx|
      Haml::Engine.new(File.read("#{path}/#{page}.haml"), :format => :html5, :ugly => true).render(ctx)
    end

end

run toto

