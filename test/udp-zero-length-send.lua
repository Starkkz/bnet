#!/usr/bin/lua

--[[
Show that luasocket returns an error message on zero-length UDP sends,
even though the send is valid, and in fact the UDP packet is sent
to the peer:

% sudo tcpdump -i lo -n
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on lo, link-type EN10MB (Ethernet), capture size 65535 bytes
13:40:16.652808 IP 127.0.0.1.56573 > 127.0.0.1.5432: UDP, length 0

]]

local socket = require("bnet")

s = assert(socket.udp())
r = assert(socket.udp())
assert(r:setsockname("*", 5432))
assert(s:setpeername("127.0.0.1", 5432))

ssz, emsg = s:send("")

print(ssz == 0 and "OK" or "FAIL",[[send:("")]], ssz, emsg)

