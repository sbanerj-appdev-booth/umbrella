p "Where are you located?"

user_location = gets.chomp

#p user_location

gmaps_key =ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

#p gmaps_url

require "open-uri"

raw_data = URI.open(gmaps_url).read

#p raw_data.split

require "json"

parsed_data = JSON.parse(raw_data)


results_array = parsed_data.fetch("results")
#p results_array

first_result = results_array.at(0)

geo = first_result.fetch("geometry")
loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

p latitude
p longitude

#weather

dark_sky_key = ENV.fetch("DARK_SKY_KEY")

dark_sky_url = "https://api.darksky.net/forecast/#{dark_sky_key}/#{latitude},#{longitude}"

temp_data = URI.open(dark_sky_url).read

parsed_temp_data = JSON.parse(temp_data)

currently_hash = parsed_temp_data.fetch("currently")

current_temp = currently_hash.fetch("temperature")

puts "It is currently #{current_temp}°F."

#Get your credentials from your Twilio dashboard, or from Canvas if you're using mine

twilio_sid = ENV.fetch("TWILIO_SID")
twilio_token = ENV.fetch("TWILIO_KEY")
twilio_sending_number = ENV.fetch("TWILIO_PH_NUM")

require "twilio-ruby"
# Create an instance of the Twilio Client and authenticate with your API key
twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

# Craft your SMS as a Hash literal with three keys
sms_info = {
  :from => twilio_sending_number,
  :to => ENV.fetch("MY_PH_NUM"), # Put your own phone number here if you want to see it in action
  :body => "It's going to rain today — take an umbrella!"
}

# Send your SMS!
twilio_client.api.account.messages.create(sms_info)
