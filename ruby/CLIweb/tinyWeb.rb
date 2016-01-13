require 'socket'

host = 'www.tutorialspoint.com'
port = 80
path = '/index.html'

get_request = "GET /index.html HTTP/1.0\r\nHost: www.tutorialspoint.com\r\n\r\n"
post_request = "POST"
puts request

socket = TCPSocket.open(host, port)
socket.print(request)
puts socket.read
