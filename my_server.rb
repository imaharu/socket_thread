require "socket"
require "./s_class"

server= Server.new(10)

sock = TCPServer::open(server.host, server.port).accept
loop do
    from = sock.gets().chomp() + "@" + sock.peeraddr()[2]
    while (line = sock.gets())
        puts line
        args = line.split(" ")
        op = args[0]
        if op.eql?("put")
            server.put(args[1], args[2], from, sock)
        elsif op.eql?("get")
            server.get(args[1], sock)
        end
    end
    break
end
sock.close
