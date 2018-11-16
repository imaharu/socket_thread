require "socket"

server= Server.new(10)

sock = TCPServer::open(server.host, server.port).accept
loop do
    from = sock.gets().chomp() + "@" + sock.peeraddr()[2]
    while (line = sock.gets())
        args = line.split(" ")
        op = args[0]
        puts op
        if op.eql?("put")
            puts "Here is put"
            server.put(args[1], args[2], from, sock)
        end
        puts server.memo_data[2]
        puts server.memo_from[2]
        puts server.memo_pass[2]
        puts server.memo_text[2]
        break
    end
    break
end
sock.close
