-- Send Alarm status to HomeServer
-- some code taken from ok1cdj
-- 2015 AReResearch (Andy Reischle)

-- Status per pin
-- 0 = ledig
-- 1 = upptagen
-- 2 = troligen ledig


-- Pin 3 HIGH = Upptagen
-- Pin 3 LOW = Ledig
-- Pin 4 HIGH = Troligen ledig


print("Booting")


SensorID = "IS" -- Vilken toa
status = 0 -- eller "0"
oldstatus = 0

gpio.mode(3,gpio.INPUT,gpio.FLOAT) -- upptagen och ledig
gpio.mode(4,gpio.INPUT,gpio.FLOAT) -- upptagen

tmr.alarm(0, 1000, 1, function() -- Set alarm to one second
	if gpio.read(3)==1 and gpio.read(4)==0 then 
		status=1 
	elseif gpio.read(3)==0 and gpio.read(4)==0 then
		status=0
	else 
		status=2 
	end

    	if status ~= oldstatus then 
		sendalarm (SensorID,status) 
	end

	oldstatus = status
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