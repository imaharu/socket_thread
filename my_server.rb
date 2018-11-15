require "socket"

class Chat
    attr_accessor :host, :port
    def initialize(host="192.168.3.7", port=40000)
        @host = host
        @port = port
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
    from = sock.gets()
    puts from
    break
end
sock.close
