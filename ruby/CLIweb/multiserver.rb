require 'socket'

server = TCPServer.open(2000)

loop {
  Thread.start(server.accept) do |client|
    client.puts(Time.new.ctime)
    client.puts "Closing connection, bye!"
    client.close
  end
}
