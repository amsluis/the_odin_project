require 'net/http'

# The long way, passing in web server and then generating the request

Net::HTTP.start('www.rubyinside.com') do |http|
  req = Net::HTTP::Get.new('/test.txt')
  puts http.request(req).body
end

# The URI library to generate the host, port, path, etc. information
#   from a single URL. URI is loaded along with net/http.

url = URI.parse('http://www.rubyinside.com/test.txt')
Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Get.new(url.path)
  puts http.request(req).body
end

# Simplify with get_response method

url = URI.parse('http://www.rubyinside.com/test.txt')
response = Net::HTTP.get_response(url)
puts response.body

p Net::HTTP::Get.new(url.path)
