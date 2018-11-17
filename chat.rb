class Chat
    attr_accessor :host, :port
    def initialize(host=ENV["th_ip"], port=40000)
        @host = host
        @port = port
    end
end
