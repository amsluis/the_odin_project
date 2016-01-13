require 'socket'

server = TCPServer.open(2000)
loop {
  Thread.start(server.accept) do |client|
    request = client.readline.split(' ')
    method, path, version = request
    path = '.' + path
    puts path
    if method == "GET"
      if File.exist?(path)
        puts 'does exist'
        message = File.open(path).read
        message_length = message.length
        puts message_length
        client.puts "HTTP/1.0 200 OK\r\nDate: #{Time.now.ctime}\r\nContent-Type: text/html\r\nContent-Length: #{message_length}\r\n\r\n"
        client.puts message
        client.close
      else
        client.print "HTTP/1.0 404 File Not Found\r\n"
        client.close
      end
    end
    if method == "POST"
      client.print "HTTP/1.0 405 Method Now Allowed"
      client.close
    end
  end
}

