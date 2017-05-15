require 'sinatra'
require 'rack-flash'
require 'dotenv'
require 'twilio-ruby'
require 'json'
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
  @contact_names = JSON.parse(ENV['CONTACTS_ARRAY']).map { |name, number| name }
	erb :home
end

post '/arrived_safely' do
  client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  contacts = Hash[JSON.parse(ENV['CONTACTS_ARRAY']).map {|key, value| [key, value]}]
  location = params[:location]
  begin
    contacts.each do |name, number|
      client.messages.create(
        from: '+12406502723',
        to: "+1#{number}",
        body: "Hi #{name}, it's Ariel. I'm sending you a text from #{location}. I just wanted to let you know I got in safe and sound :) Hope you're doing well! XOXO"
      )
    end
	  flash[:success] = "sent a message from #{location}"
  rescue => e
    flash[:error] = e.message
  end
end
