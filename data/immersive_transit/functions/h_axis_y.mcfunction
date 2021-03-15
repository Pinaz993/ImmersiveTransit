#say HY
#For iteration sake!
scoreboard objectives add y_counter dummy
#Grab the height of the portal and put it in our counter.
execute store result score immersive_transit y_counter run data get entity @s height
#This function calls itself unless the counter we set is at 0. Call it a poor-man's do-while loop.
function immersive_transit:move_dest_y
#Clean up a bit of unused memory.
scoreboard objectives remove y_counter