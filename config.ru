require 'toto'
require 'haml'

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

use Rack::ShowExceptions if ENV['RACK_ENV'] == 'development'

toto = Toto::Server.new do
  set :author, "Daria Rosyuk"
  set :title, "Daria's place"
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :ext, "md"
  set :url,     'http://daria-ro-blog.heroku.com'
  # set :title,     Dir.pwd.split('/').last                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  # set :markdown,  :smart                                    # use markdown + smart-mode
  # set :disqus,    false                                     # disqus id, or false
  # set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  # set :cache,      28800                                    # cache duration, in seconds
  set :to_html do |path, page, ctx|
      Haml::Engine.new(File.read("#{path}/#{page}.haml"), :format => :html5, :ugly => true).render(ctx)
    end
  set :error do |code|
    # fake the bindings for the layout haml
    class LayoutCtx
      def title; 'title' end
      def archives; "" end
    end
    
    Haml::Engine.new(File.read("templates/layout.haml")).render(LayoutCtx.new) do |content|
      Haml::Engine.new(File.read("templates/pages/error.haml")).render(Object.new,:code => code)
    end
  end
end

run toto


