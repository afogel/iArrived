require 'sinatra'
require 'rack-flash'
require 'dotenv'
require 'twilio-ruby'

# Configuration
Dotenv.load
APP_ROOT = Pathname.new(File.expand_path('../', __FILE__))
configure do
	set :root, APP_ROOT.to_path
	set :views, File.join(Sinatra::Application.root, "app", "views")
end

enable :sessions
use Rack::Flash

# Routing
get '/' do
	erb :home
end

post '/arrived_safely' do
  @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
#  @client = Twilio::REST::Client.new(ENV['TWILIO_API_KEY'], ENV['TWILIO_SECRET'], ENV['TWILIO_ACCOUNT_SID'])
  @client.messages.create(
    from: '+12406502723',
    to: '+13013258434',
    body: "It's working"
  )
	flash[:success] = 'it worked'
end
