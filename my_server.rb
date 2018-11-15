require "socket"

class Chat
    attr_accessor :host, :port, :n_memo
    def initialize(host="", port=40000, n_memo=10)
        @host = host
        @port = port
        @n_memo = n_memo
    end
end

class Server < Chat
    attr_accessor :memo_data, :memo_from, :memo_pass, :memo_text
    def initialize(time)
        super()
        @memo_data = []
        @memo_from = []
        @memo_pass = []
        @memo_text = []
        set_nil(@memo_data, time)
        set_nil(@memo_from, time)
        set_nil(@memo_pass, time)
        set_nil(@memo_text, time)
    end

    def put(n, password, from , sock)
        n = n.to_i()
        if (n  < 0 || @n_memo < n)
            sock.puts("ERR")
        elsif (@memo_text[n] == nil)
            text = ""
            while (line = sock.gets())
                if ( line == "\n")
                    break
                end
                text += line
            end
            puts "pass"
            @memo_data[n] = Time::now()
            @memo_from[n] = from
            @memo_pass[n] = password
            @memo_text[n] = text
            sock.puts("put success ")
        else
            sock.puts("put error ")
        end
    end


    private

    def set_nil(array, time)
        time.times do |i|
            array[i] = nil
        end
    end
end

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
