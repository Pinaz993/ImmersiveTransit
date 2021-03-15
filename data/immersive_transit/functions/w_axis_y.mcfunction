#For iteration sake!
scoreboard objectives add y_counter dummy
#Grab the width of the portal and put it in our counter.
execute store result score immersive_transit y_counter run data get entity @s width
#Orient the portal towards positive Y (does not change the shape of the portal, only the heading of the entity).
tp @s ~ ~ ~ 0 -90
#This function calls itself unless the counter we set is at 0. Call it a poor-man's do-while loop.
function immersive_transit:move_dest_y
#Clean up a bit of unused memory.
scoreboard objectives remove y_counter
#We're here because the width axis was Y. If the height axis is X, then we need to move toward positive Z, and visa versa.
#If height was X, teleport .5 in the positive Z direction.
execute if entity @s[nbt={axisHX:1.0d}] as @e[tag=transit_placeholder] at @e[tag=transit_placeholder] run tp @s ~ ~ ~.5
#If height was Z, teleport .5 in the positive X direction.
execute if entity @s[nbt={axisHZ:1.0d}] as @e[tag=transit_placeholder] at @e[tag=transit_placeholder] run tp @s ~.5 ~ ~