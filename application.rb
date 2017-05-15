require 'sinatra'

configure do
  set :root, APP_ROOT.to_path
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

get '/' do
  "<button style='margin: 80px auto; display: block; width: 50%; height: 50%; font-size: 32px'>I arrived safely!</button>" 
end

post '/arrived_safely' do
  flash[:success]
end
