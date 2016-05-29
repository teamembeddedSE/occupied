# occupied

/************************************************************************************

								  Occupied

************************************************************************************/

Occupied is a project, made by a couple of student as a project in school. 

It all started when we wanted to learn Raspberry Pie, and decided that the best
way to learn, was by doing something and basically practise learning by doing.


Occupied is, in its simpliest form, a sensor checking if the bathroom is occupied
and sends the status to our website. 


We accomplish this by having a switch in the doorframe, that closes when the
bathroomdoor is locked. The switch is in its turn connected to the wifi module 
ESP 8266, that checks the status of the switch and sends the update to our website. 


It is running from battery so we have put a lot of thought in to making the battery 
last as long as possible. The way that we did it is by having the wifimodule sleeping
while the door is not locked, and as soon that the door is locked, the module wakes 
up and sends the status. When the door is opened, the module sends a status again and
then goes to sleep. 

We took inpiration form here http://www.esp8266.com/viewtopic.php?f=11&t=4458 for the 
schematics. 

The ESP module is programmed with Lua and you will find the code in this repositary. 

/************************************************************************************

								Team Embedded

************************************************************************************/

Power saving tips
https://github.com/z2amiller/sensorboard/blob/master/PowerSaving.md

