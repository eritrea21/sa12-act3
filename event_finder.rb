require 'net/http'
require 'json'

class EventFinder
  def initialize(api_key)
    @api_key = api_key
    @base_url = 'https://www.eventbriteapi.com/v3/events/search/'
  end

  def find_events(location)
    uri = URI.parse(@base_url)
    uri.query = URI.encode_www_form_component("q=#{location}&token=#{@api_key}")

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      events_data = JSON.parse(response.body)
      events = events_data['events']

      events.each do |event|
        name = event['name']['text']
        venue = event['venue']['name']
        date = event['start']['local']
        time = event['start']['local'].split('T')[1]

        puts "Name: #{name}"
        puts "Venue: #{venue}"
        puts "Date: #{date}"
        puts "Time: #{time}"
        puts "------------------------"
      end
    else
      puts "Error: #{response.message}"
    end
  end
end

# Usage example:
api_key = '56TY7UTHQWRP52RDVEG6'
event_finder = EventFinder.new(api_key)
event_finder.find_events('New York, NY') # Replace 'New York' with the desired location
