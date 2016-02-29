-- node.dsleep() to get the module sleeping


print("Booting\n")

SensorID = "IS" -- Bathroom name
GPIO0 = 3
GPIO2 = 4
AVAILABLE = 0
OCCUPIED = 1

gpio.mode(GPIO0,gpio.OUTPUT) -- GPIO0 sets as OUTPUT
gpio.write(GPIO0, gpio.HIGH) -- Holds CH_PD HIGH
gpio.mode(GPIO2,gpio.INPUT,gpio.FLOAT) -- Reads if door is closed

status = OCCUPIED




tmr.alarm(0, 10000, 1, function() -- Set alarm to one second
sendalarm(SensorID,status)

	if gpio.read(GPIO2)==0 then -- If the button is released
		status=OCCUPIED 
		sendalarm(SensorID,status)
		print("Going to sleep\n")
		--gpio.write(GPIO0,gpio.LOW) -- Holds CH_PD LOW, Should make ESP sleep ZZZzzZZZ
		print("This should not be seen\n") -- Should not be printed since ZZZzzZZZ
	--else
		--print("GPIO2: ", gpio.read(GPIO2))
		--print("\n")
	end

end)


function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end

function sendalarm(SensorID,status)
print("Open connection...")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end) 
-- Add you servers ip address here.
-- If you use a host name/FQDN, it has to be all CAPITALS (Thanks Lee Rayner!) 
conn:connect(80,'46.30.212.131') 
conn:send("GET molk/toa/index.php/set/1/" .. status .. " HTTP/1.1\r\n") 
conn:send("Host: WWW.MARCUSJOHANSSON.NET\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")
conn:on("disconnection", function(conn)
     print("Disconnected...")
        end)
end
