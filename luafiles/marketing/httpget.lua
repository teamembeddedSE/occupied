

function doGet(host,request)

	conn=net.createConnection(net.TCP, 0) 

	-- show the retrieved web page

	conn:on("receive", function(conn, payload) 
						   success = true
						   print(payload) 
						   end) 

	-- when connected, request page (send parameters to a script)
	conn:on("connection", function(conn, payload) 
						   print('\nConnected') 
						   conn:send("GET "..request
							.." HTTP/1.1\r\n" 
							.."Host: "..host.."\r\n" 
							.."Connection: close\r\n"
							.."Accept: */*\r\n" 
							.."User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n" 
							.."\r\n")
							collectgarbage() 
						   end) 
	-- when disconnected, let it be known
	conn:on("disconnection", function(conn, payload) 
							print('\nDisconnected') 
							collectgarbage()
							if gpio.read(GPIO2) == 0 then
							
								gpio.write(GPIO0,gpio.LOW) -- Holds CH_PD LOW, Should make ESP sleep ZZZzzZZZ
							
							end
							
							end)
												 
	conn:connect(80,host) 
end