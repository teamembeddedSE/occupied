-- node.dsleep() to get the module sleeping
require('httpget')

print("Booting\n")

IS = 1 
SensorID = IS -- Bathroom name
GPIO0 = 3
GPIO2 = 4
AVAILABLE = 0
OCCUPIED = 1

host = "192.168.153.206"

--print("/set.php?bathroomID=".. SensorID .."&status=" .. AVAILABLE)
gpio.mode(GPIO0,gpio.OUTPUT) -- GPIO0 sets as OUTPUT
gpio.write(GPIO0, gpio.HIGH) -- Holds CH_PD HIGH
gpio.mode(GPIO2,gpio.INT,gpio.PULLUP) -- Reads if door is closed
bat = adc.read(0)
print(wifi.sta.getip())
doGet(host,"/set.php?bathroomID=".. SensorID .."&status=" .. OCCUPIED .."&bat=" ..bat)
	
function doSleep()
		doGet(host,"/set.php?bathroomID=".. SensorID .."&status=" .. AVAILABLE .."&bat=" ..bat)
		print("Going to sleep\n")
end

gpio.trig(GPIO2, 'down', doSleep)