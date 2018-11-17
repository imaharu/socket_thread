require "etc"
require "socket"
require "./c_class.rb"
require "thread"
client = Client.new()
begin
    sock = TCPSocket::open(client.host, client.port)
rescue
    puts "TCPSocket.open failed :#$!"
end

sock.puts(Etc::getlogin())

Thread::start() do
    while (line = $stdin.gets())
        sock.puts(line) 
    end
    exit(0)
end

while (line = sock.gets())
    puts("> " + line)
end
exit()
