require 'httparty'
require 'json'

# Method to fetch weather data from OpenWeatherMap API
def fetch_weather_data(api_key, city)
  url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=metric"
  response = HTTParty.get(url)

  if response.success?
    return JSON.parse(response.body)
  else
    puts "Error: #{response.code}, #{response.message}"
    return {}
  end
end

# Method to calculate average temperature from weather data
def calculate_average_temperature(weather_data)
  temperature_sum = 0
  count = 0

  weather_data.each do |data|
    temperature_sum += data['main']['temp']
    count += 1
  end

  return temperature_sum / count if count > 0
  return nil
end

# Replace 'your_api_key' with your actual API key from OpenWeatherMap
api_key = 'a30e5414ef39a3dee45e432a2204b06c'
city = 'Memphis'  # Specify the city for which you want to fetch weather data

# Fetch weather data
weather_data = fetch_weather_data(api_key, city)

if weather_data.any?
  # Extract relevant information
  temperature = weather_data['main']['temp']
  humidity = weather_data['main']['humidity']
  weather_conditions = weather_data['weather'][0]['description']

  # Display weather information for the specified city
  puts "Weather in #{city}:"
  puts "Temperature: #{temperature}°C"
  puts "Humidity: #{humidity}%"
  puts "Weather Conditions: #{weather_conditions}"
else
  puts "No weather data available for #{city}."
end
