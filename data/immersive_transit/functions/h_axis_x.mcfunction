#say HX
#For iteration sake!
scoreboard objectives add x_counter dummy
#Grab the height of the portal and put it in our counter.
execute store result score immersive_transit x_counter run data get entity @s height
#This function calls itself unless the counter we set is at 0. Call it a poor-man's do-while loop.
function immersive_transit:move_dest_x
#Clean up a bit of unused memory.
scoreboard objectives remove x_counter