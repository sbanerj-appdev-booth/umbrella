p "Where are you located?"

user_location = "Houston"

p user_location

gmaps_key =ENV.fetch("GMAPS_KEY")

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

#p gmaps_url

require "open-uri"

raw_data = URI.open(gmaps_url).read

p raw_data.split

require "json"

parsed_data = JSON.parse(raw_data)


results_array = parsed_data.fetch("results")
p results_array

first_result = results_array.at(0)

geo = first_result.fetch("geometry")
loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

p latitude
p longitude
