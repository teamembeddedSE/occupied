--if wifi.sta.getip()==nil then
--	wifi.setmode(wifi.STATION)
--	wifi.sta.config("Molk","Molk0901")
--end

tmr.alarm(2,1000, 1, function() 

	if wifi.sta.getip()==nil then 
		print("Wait for IP address!") 
	else 
		print("New IP address is "..wifi.sta.getip()) 
		tmr.stop(2)
		tmr.alarm(1, 1000, 0, function() dofile("main.lua") end)
	end 
	
end)
