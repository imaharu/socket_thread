require "socket"
require "./chat"

class Server < Chat
    attr_accessor :memo_date, :memo_from, :memo_pass, :memo_text, :n_memo
    def initialize(time)
        super()
        @memo_date = []
        @memo_from = []
        @memo_pass = []
        @memo_text = []
        @n_memo = time
        set_nil(@memo_date, time)
        set_nil(@memo_from, time)
        set_nil(@memo_pass, time)
        set_nil(@memo_text, time)
    end

    def put(n, password, from , sock)
        n = n.to_i()
        if (n  < 0 || @n_memo < n)
            sock.puts("Put Error: n is different")
        elsif (@memo_text[n] == nil)
            text = ""
            while (line = sock.gets())
                if ( line == ".\n")
                    break
                end
                text += line
            end
            @memo_date[n] = Time::now()
            @memo_from[n] = from
            @memo_pass[n] = password
            @memo_text[n] = text
            sock.puts("Put Success")
        else
            sock.puts("Put Error: memo_text or lock")
        end
    end

    def get(n, sock)
        n = n.to_i()
        date_n = @memo_date[n]
        from_n = @memo_from[n]
        text_n = @memo_text[n]

        if (n < 0 || @n_memo <= n)
            sock.puts("Get Error: n is different")
        elsif (date_n && text_n)
            sock.puts("Get Success")
            sock.print("Data: ")
            sock.puts(date_n.to_s())
            sock.print("From: ")
            sock.puts(from_n + "\n")
            sock.puts(text_n)
            sock.puts(".")
        end
    end

    private

    def set_nil(array, time)
        time.times do |i|
            array[i] = nil
        end
    end
end
