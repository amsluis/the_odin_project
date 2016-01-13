require 'net/http'
host = 'www.tutorialspoint.com'
path = '/index.htm'

http = Net::HTTP.new(host)
response = http.get(path)
puts response.body
