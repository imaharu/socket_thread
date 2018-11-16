require "socket"

client = Client.new()
sock = TCPSocket::open(client.host, client.port)
sock.puts("a")
sock.puts("put 2 my_pass")
