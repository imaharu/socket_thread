class Chat
    attr_accessor :host, :port, :n_memo
    def initialize(host="", port=40000)
        @host = host
        @port = port
    end
end
