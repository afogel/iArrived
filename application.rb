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
  p ENV['CONTACTS_ARRAY']
  contacts = Hash[ENV['CONTACTS_ARRAY'].map {|key, value| [key, value]}]
  p contacts
  #@client.messages.create(
  #  from: '+12406502723',
  #  to: "+1#{number}",
  #  body: "Hi #{name}, it's Ariel. I'm sending you a text from #{location}. I just wanted to let you know I got in safe and sound :) Hope you're doing well! XOXO"
  #)
	flash[:success] = 'it worked'
rescue => e
  flash[:error] = e.message
end
