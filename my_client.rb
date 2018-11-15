require "socket"

class Chat
    attr_accessor :host, :port
    def initialize(host="192.168.3.7", port=40000)
        @host = host
        @port = port
    end
end

class Client < Chat
    def initialize()
        super()
    end
end

client = Client.new()
sock = TCPSocket::open(client.host, client.port)
sock.puts("a")
sock.puts("put 2 my_pass")
