require "socket"

class Server < Chat
    attr_accessor :memo_data, :memo_from, :memo_pass, :memo_text
    def initialize(time)
        super()
        @memo_data = []
        @memo_from = []
        @memo_pass = []
        @memo_text = []
        @n_memo = time
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
