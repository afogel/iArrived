require 'sinatra'

APP_ROOT = Pathname.new(File.expand_path('../../iArrived', __FILE__))
configure do
  set :root, APP_ROOT.to_path
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

get '/' do
  erb :home
end

post '/arrived_safely' do
  flash[:success]
end
