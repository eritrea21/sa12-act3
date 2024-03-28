require 'net/http'
require 'json'

def fetch_exchange_rate(source_currency, target_currency)
  api_key = 'f17605ba5f49d0ac3859200a711853ef'
  url = "https://open.er-api.com/v6/latest/#{source_currency}"

  uri = URI(url)
  response = Net::HTTP.get(uri)

  if response.nil?
    puts "Error: Unable to fetch exchange rates from the API"
    return
  end

  data = JSON.parse(response)

  if data.key?('error')
    puts "Error: #{data['error']['description']}"
    return
  end

  exchange_rate = data['rates'][target_currency]

  if exchange_rate.nil?
    puts "Error: Unable to find exchange rate for #{target_currency}"
    return
  end

  exchange_rate
end

def convert_currency(amount, source_currency, target_currency)
  exchange_rate = fetch_exchange_rate(source_currency, target_currency)

  if exchange_rate.nil?
    return
  end

  converted_amount = amount * exchange_rate
  puts "#{amount} #{source_currency} is equal to #{converted_amount} #{target_currency}"
end

puts "Enter amount to convert: "
amount = gets.chomp.to_f

puts "Enter source currency (e.g. USD, EUR): "
source_currency = gets.chomp.upcase

puts "Enter target currency (e.g. USD, EUR): "
target_currency = gets.chomp.upcase

convert_currency(amount, source_currency, target_currency)
