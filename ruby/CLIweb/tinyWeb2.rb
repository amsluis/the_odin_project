require 'socket'

kill = false
puts "Welcome to the World Wide Web!"

while kill == false
  puts 'What would you like to do?'
  puts 'GET, POST, or exit?'
  response = gets.chomp.downcase
  if response.include? 'get'
    socket = TCPSocket.open('localhost', 2000)
    socket.puts "GET /index.html HTTP/1.0\r\nHost: localhost\r\n"
    puts 'message sent'
    resp = socket.read
    puts resp.split("\r\n\r\n")
    socket.close
  elsif response.include? 'post'
    socket = TCPSocket.open('localhost', 2000)
    puts 'post selected'
    socket.puts "POST /index.html HTTP/1.0\r\nHost: localhost\r\n\r\nName: Aaron\r\nEmail: amsluis@gmail.com"
    puts socket.read
    socket.close
  elsif response.include? 'exit'
    kill = true
  else
    puts "I'm sorry, I didn't quite get that.\nTry again."
  end
end
